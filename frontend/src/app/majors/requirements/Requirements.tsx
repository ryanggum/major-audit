
"use client";
import { useAuth } from "@/app/providers";

import { useState } from "react";
import Style from "./Requirements.module.css";

import { Course } from "@/types/type-user";
import { ConcentrationSubrequirement, ConcentrationRequirement, DegreeConcentration, MajorsIndex } from "@/types/type-program";

import { removeCourseInSubreq } from "./RequirementsUtils";
import { MajorsIcon } from "../course-icon/MajorsCourseIcon";

function RenderSubrequirementCourse(props: { edit?: boolean; course: Course | null; subreq: ConcentrationSubrequirement; onRemoveCourse: Function }) 
{
  const matchingStudentCourse = props.subreq.student_courses_satisfying.find(
    (studentCourse) => studentCourse.course === props.course
  );

  return (
    <div style={{ marginRight: "2px", marginBottom: "2px" }}>
      <MajorsIcon 
        edit={props.edit ?? false} 
        contentCourse={matchingStudentCourse ?? props.course} 
        subreq={props.subreq} 
        onRemoveCourse={props.onRemoveCourse} 
      />
    </div>
  );
}

function RenderSubrequirement(props: { edit: boolean, majorsIndex: MajorsIndex, reqIndex: number, subreqIndex: number, subreq: ConcentrationSubrequirement }) 
{
	const { setUser } = useAuth();
	function handleRemoveCourse(course: Course | null, isStudentCourse: boolean = false) {
    removeCourseInSubreq(setUser, props.majorsIndex, props.reqIndex, props.subreqIndex, course, isStudentCourse);
  }

  return (
    <div className={Style.Column} style={{ marginBottom: "12px" }}>
      <div className={Style.SubHeader} style={{ marginBottom: "2px" }}>
        {props.subreq.student_courses_satisfying.length}|{props.subreq.courses_required} {props.subreq.subreq_name}
      </div>
      <div className={Style.SubDesc}>
				{props.subreq.subreq_desc}
			</div>
      <div className={Style.Row} style={{ flexWrap: "wrap", marginLeft: "20px" }}>
        {props.subreq.courses_options.map((course, course_index) => (
          <RenderSubrequirementCourse 
						key={course_index}
						course={course} 
						subreq={props.subreq}
						edit={props.edit}
						// {...(props.subreq.courses_any_bool ? { edit: props.edit } : {})} 
						onRemoveCourse={handleRemoveCourse}
					/>
        ))}
      </div>
    </div>
  );
}

function RenderRequirement(props: { edit: boolean, majorsIndex: MajorsIndex, reqIndex: number, req: ConcentrationRequirement })
{
  return(
    <div className={Style.Column}>
      <div className={Style.Row} style={{ marginBottom: "2px", justifyContent: "space-between" }}>
        <div className={Style.ReqHeader}>
					{props.req.req_name}
				</div>
        <div className={Style.ReqHeader} style={{ marginRight: "20px" }}>
          {props.req.checkbox !== undefined ? props.req.courses_satisfied_count === props.req.courses_required_count ? "✅" : "❌" : `${props.req.courses_satisfied_count}|${props.req.courses_required_count}`}
        </div>
      </div>
			<div className={Style.SubDesc}>
					{props.req.req_desc}
			</div>
			<div className={Style.ReqsList}>
        {props.req.subreqs_list.map((subreq, subreq_index) => (
          <RenderSubrequirement 
						key={subreq_index} 
						edit={props.edit} 
						majorsIndex={props.majorsIndex}
						reqIndex={props.reqIndex} 
						subreqIndex={subreq_index} 
						subreq={subreq} 
					/>
        ))}
      </div>
    </div>
  );
}

function Requirements(props: { conc: DegreeConcentration | null, majorsIndex: MajorsIndex })
{
	const [edit, setEdit] = useState(false);

	if(props.conc == null){
		return(
			<div className={Style.RequirementsContainer}>
				<div className={Style.RequirementsContainerHeader}>
          Requirements
        </div>
			</div>
		)
	}

	return(
    <div className={Style.RequirementsContainer}>
      <div className={`${Style.RequirementsContainerHeader} ${props.conc.user_status == 1 ? Style.GoldBackground : ""}`}>
        <div>Requirements</div>
				{props.conc.user_status == 1 && <div className={Style.EditButton} onClick={() => setEdit(!edit)}>⚙</div>}
      </div>
			<div className={Style.ReqsList}>
				{props.conc.conc_reqs.map((req, i) => (
					<RenderRequirement key={i} edit={edit} majorsIndex={props.majorsIndex} reqIndex={i} req={req}/>
				))}
			</div>
    </div>
  );
}

export default Requirements;
