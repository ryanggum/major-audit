
import React from "react";
// import styles from "./App.module.css";

import { Route, Routes } from 'react-router-dom';

import Navbar from './navbar/NavBar';
import Courses from './pages/Courses';
import Graduation from './pages/Graduation';
import Majors from './pages/Majors';

function App() {
  return (
  <>
    <Navbar/>
    <div>
      <Routes>
        <Route path=""             element={<Graduation />} />      
        <Route path="/courses"      element={<Courses/>} />
        <Route path="/majors"       element={<Majors/>}/>
      </Routes>
    </div>
  </>
  
  );
}

export default App;
