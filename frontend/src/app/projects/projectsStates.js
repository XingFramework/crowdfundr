import {State, Resolve, Inject} from "stateInjector";

@State("root.inner.project")
export class ProjectState {
  constructor() {
    this.url = "/project/:id";
    this.templateUrl = "projects/project.tpl.html";
    this.controller = "ProjectCtrl";
    this.controllerAs = "projectCtrl";
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

@State("root.inner.projectEdit")
export class ProjectEditState {
  constructor() {
    this.url = "/edit/:id";
    this.templateUrl = "projects/project-edit.tpl.html";
    this.controller = "ProjectEditCtrl";
    this.controllerAs = "projectCtrl";
  }
  @Resolve('resources', '$stateParams')
  project(resources, $stateParams) {
    return resources.project($stateParams).load();
  }
}
