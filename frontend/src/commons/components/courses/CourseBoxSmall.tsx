import React, { useContext } from "react";
import styles from "./CourseBoxSmall.module.css";

import "react-tooltip/dist/react-tooltip.css";
import { Tooltip } from "react-tooltip";
import { Season, StudentCourse, Course, Distribution } from "../../types/TypeCourse";

import img_fall from "./../../images/fall.png";
import img_spring from "./../../images/spring.png";

import DistributionCircle from "./DistributionsCircle";

function CourseSeasonIcon(props: { seasons: Array<Season> }) {
  const seasonImageMap = {
    FALL: img_fall,
    SPRING: img_spring,
    SUMMER: "summer.png",
  };

  return (
    <div style={{ display: "flex", marginRight: "2px", marginTop: "3px" }}>
      {props.seasons.map((szn, index) => (
        <div key={index} style={{ marginLeft: index > 0 ? "-7.5px" : 0 }}>
          {seasonImageMap[szn] && (
            <img
              style={{ width: "15px", height: "15px" }}
              src={seasonImageMap[szn]}
              alt={szn}
            />
          )}
        </div>
      ))}
    </div>
  );
}

function DistCircDiv(props: { dist: Array<Distribution> }){
  return(
    <div style={{ marginLeft: "2px", marginTop: "2px" }}>
      <DistributionCircle distributions={props.dist}/>
    </div>
  );
}

function CheckMark(props: { studentCourse: StudentCourse }){
  return(
    <div>
      {props.studentCourse.enrollmentStatus === "COMPLETED" ? (
          <div style={{ paddingLeft: "1px", paddingRight: "3px" }}>
            <div data-tooltip-id="check-tooltip" data-tooltip-content="Credit Confirmed by Yale" data-tooltip-place="top">
              ✓
            </div>
            <Tooltip id="check-tooltip" style={{ backgroundColor: "#444444", borderRadius: "3px"}}/>
          </div>
        ) : (
          ""
        )}
    </div>
  );
}

function CourseBoxSmall(props: { studentCourse?: StudentCourse, course?: Course } ) {
  
  if(props.course && props.studentCourse == null) 
  {
    return(
      <div className={styles.CourseBox} style={{ backgroundColor: "#F5F5F5" }}>
        <CourseSeasonIcon seasons={props.course.seasons}/>
        {props.course.code}
        {props.course.distribution.length > 0 ? (<DistCircDiv dist={props.course.distribution}/>) : ("")}
      </div>
    );
  }
  else 
  if(props.course == null && props.studentCourse) 
  {
    return (
      <div className={styles.CourseBox} style={{ backgroundColor: "#F5F5F5" }}>
        <CheckMark studentCourse={props.studentCourse}/>
        <CourseSeasonIcon seasons={[props.studentCourse.season]} />
        {props.studentCourse.course.code}
        {props.studentCourse.course.distribution.length > 0 ? (<DistCircDiv dist={props.studentCourse.course.distribution}/>) : ("")}
      </div>
    );
  }
  return <div/>
}

export default CourseBoxSmall;
