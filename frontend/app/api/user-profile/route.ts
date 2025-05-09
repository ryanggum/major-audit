// UPDATED: frontend/app/api/user-profile/route.ts

import { StudentTermArrangement } from '@/types/user';
import { NextResponse } from 'next/server';
import { getSupabaseServerClient } from '@/database/server';
import { normalizeStudentCourseCreated, normalizeStudentCourseOffering } from '../student-courses/student-courses';
import { Tables } from '@/types/supabase_newer';

type CourseJoin = Tables<'student_courses'> & {
  course_offering?: Tables<'course_offerings'> & {
    course?: Tables<'courses'> & {
      course_codes?: Tables<'course_codes'>[];
    };
  };
  created_course?: Tables<'created_courses'>;
};

export async function GET() {
  try {
    const supabase = await getSupabaseServerClient();
    const { data: { user: authUser }, error: userError } = await supabase.auth.getUser();

    if (userError || !authUser) {
      return NextResponse.json({ error: 'Authentication error' }, { status: 401 });
    }

    const userId = authUser.id;

    // Fetch user and all FYPs in parallel
    const [userRes, fypsRes] = await Promise.all([
      supabase.from('users').select('*').eq('id', userId).single(),
      supabase.from('fyp').select('*').eq('user_id', userId),
    ]);

    if (!userRes.data) {
      return NextResponse.json({ error: 'User not found' }, { status: 404 });
    }

    const userData = userRes.data;
    const fypList = fypsRes.data || [];

    if (fypList.length === 0) {
      return NextResponse.json({
        user: {
          name: userData.name || '',
          netID: userData.net_id,
          FYPs: [],
        }
      });
    }

    const fypIds = fypList.map(fyp => fyp.id);

		const courseQueryRes = await supabase
		.from('student_courses')
		.select(`
			*,
			course_offering:course_offerings(
				id, term, professors, flags, course_id,
				course:courses(
					*,
					course_codes:course_codes(*)
				)
			),
			created_course:created_courses(
				id, title, code, distributions, credits
			)
		`)
		.in('fyp_id', fypIds);

    if (courseQueryRes.error || !courseQueryRes.data) {
      return NextResponse.json({ error: 'Failed to fetch student courses' }, { status: 500 });
    }

    const rawCourses = courseQueryRes.data as CourseJoin[];

    // Group courses by FYP ID
    const grouped: Record<number, CourseJoin[]> = {};
    rawCourses.forEach(sc => {
      if (sc.fyp_id === null) return;
      if (!grouped[sc.fyp_id]) grouped[sc.fyp_id] = [];
      grouped[sc.fyp_id].push(sc);
    });

    const transformedFYPs = fypList.map(fyp => {
			const studentCourses = (grouped[fyp.id] || []).map(sc => {
				if (sc.created_course) {
					return normalizeStudentCourseCreated(sc, sc.created_course);
				} else if (sc.course_offering) {
					return normalizeStudentCourseOffering(
						sc,
						sc.course_offering,
						sc.course_offering?.course ?? null,
						sc.course_offering?.course?.course_codes ?? []
					);
				} else {
					throw new Error('Student course is missing both offering and created course');
				}
			});

			let studentTermArrangement: StudentTermArrangement = {};
			try {
				if (typeof fyp.term_arrangement === "object") {
					studentTermArrangement = fyp.term_arrangement as StudentTermArrangement;
				} else if (typeof fyp.term_arrangement === "string") {
					studentTermArrangement = JSON.parse(fyp.term_arrangement) as StudentTermArrangement;
				}
			} catch (error) {
				console.error(`Error parsing studentTermArrangement for FYP ${fyp.id}:`, error);
			}

      return {
        id: fyp.id,
        studentCourses,
        languagePlacement: fyp.language_placement || '',
        studentTermArrangement
      };
    });

    return NextResponse.json({
      user: {
        name: userData.name || '',
        netID: userData.net_id,
        FYPs: transformedFYPs,
      }
    });
  } catch (err) {
    console.error('user-profile error:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
