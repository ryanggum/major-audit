
import { AmbiCourse } from "./TypeCourse";

interface DUS {
    name: string;
    address: string;
    email: string;
}
  
interface DegreeMetadataStats {
    courses: number;
    rating: number;
    workload: number;
    type: string;
}
  
// type DegreeType = 'BACH_ART' | 'BACH_SCI' | 'BACH_INTENSIVE';
  
interface DegreeMetadata {
    name: string;
    abbreviation: string;
    degreeType: string;
    stats: DegreeMetadataStats;
    students: number;
    about: string;
    dus: DUS;
    catologLink: string;
    wesbiteLink: string;
}
  
interface DegreeRequirementsSubsection {
    name?: string;
    description?: string;
    courses: Array<AmbiCourse>;
}
  
interface DegreeRequirements {
    name: string;
    description?: string;
    subsections: Array<DegreeRequirementsSubsection>;
}
  
export interface Degree {
    metadata: DegreeMetadata;
		codes: string[];
    requirements: Array<DegreeRequirements>;
}
  
export interface Program {
    name: string;
    abbreviation: string;
    degrees: Array<Degree>;
}
