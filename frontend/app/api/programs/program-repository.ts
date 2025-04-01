
// database/program-repository.ts

import supabase from '@/database/client';

export const ProgramRepository = {
  /**
   * Fetch complete program hierarchy with joins
   */
  async fetchProgramHierarchy() {
    // Get programs with degrees
    const { data: programs, error: programsError } = await supabase
      .from('programs')
      .select(`
        *,
        degrees(
          *,
          concentrations(
            *,
            concentration_requirements(
              *,
              requirements(
                *,
                requirement_subrequirements(
                  *,
                  subrequirements(
                    *,
                    subrequirement_options(
                      *,
                      options(*)
                    )
                  )
                )
              )
            )
          )
        )
      `);
    
    if (programsError) {
      console.error('Error fetching program hierarchy:', programsError);
      return null;
    }
    
    return programs;
  },
  
  /**
   * Fetch courses for the program hierarchy
   */
  async fetchCoursesForOptions(courseIds: number[]) {
    if (!courseIds.length) return [];
    
    const { data, error } = await supabase
      .from('courses')
      .select('*')
      .in('id', courseIds);
    
    if (error) {
      console.error('Error fetching courses:', error);
      return [];
    }
    
    return data || [];
  },

  /**
   * Fetch course codes for the given course IDs
   */
  async fetchCourseCodes(courseIds: number[]) {
    if (!courseIds.length) return [];
    
    const { data, error } = await supabase
      .from('course_codes')
      .select('*')
      .in('course_id', courseIds);
    
    if (error) {
      console.error('Error fetching course codes:', error);
      return [];
    }
    
    return data || [];
  }
};
