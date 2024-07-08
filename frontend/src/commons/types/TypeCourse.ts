
export type Season = "Fall" | "Spring";
export type Distribution = "Hu" | "So" | "Sc" | "QR" | "WR" | "L";

interface CourseEvaluation {
  rating: number;
  workload: number;
  professor: number;
}

export interface Course {
  codes: Array<string>;
  title: string;
  credit: number
  areas: Array<string>;
  skills: Array<string>
  seasons: Array<string>;
}

export interface StudentCourse {
  course: Course;
  
  status: string;
  term: number;
}
