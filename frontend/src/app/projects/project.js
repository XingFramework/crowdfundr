import {Module} from 'a1atscript';
import * as ProjectsControllers from './projectsControllers.js';
import * as ProjectsStates from './projectsStates.js';

var Project = new Module('project', [
  ProjectsControllers,
  ProjectsStates
]);

export default Project;
