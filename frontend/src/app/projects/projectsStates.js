import {State, Resolve, Inject} from "stateInjector";

@State("root.inner.project")
export class ProjectsState {
  constructor() {
    this.url = "/project/:id";
    this.templateUrl = "projects/project.tpl.html";
    this.controller = "ProjectsCtrl";
    this.controllerAs = "project";
  }
  @Resolve('resources', '$stateParams')
  project(resources, $stateParams) {
    return resources.project($stateParams).load();
  }
}

@State("root.inner.projectNew")
export class ProjectNewState {
  constructor() {
    this.url = "/project/new";
    this.templateUrl = "projects/project-new.tpl.html";
    this.controller = "ProjectNewCtrl";
    this.controllerAs = "projectCtrl";
  }
}
