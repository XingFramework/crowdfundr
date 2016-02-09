import {State, Resolve, Inject} from "stateInjector";

@State("root.inner.project")
export class ProjectsState {
  constructor() {
    this.url = "/project/:id";
    this.templateUrl = "project/project.tpl.html";
    this.controller = "ProjectCtrl";
    this.controllerAs = "project";
  }
  @Resolve('resources', '$stateParams')
  project(resources, $stateParams) {
    return resources.project($stateParams).load();
  }
}
