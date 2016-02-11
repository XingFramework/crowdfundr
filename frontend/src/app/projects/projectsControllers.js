import {Controller} from 'a1atscript';

@Controller('ProjectsCtrl', ['project'])
export class ProjectsController {
  constructor(project) {
    this.project = project;
  }
}

@Controller("ProjectNewCtrl", ["resources", "$state"])
export class ProjectNewController {
  constructor(resources, $state) {
    this.resources = resources;
    this.$state = $state;
    this.project = this.resources.projects().new();
    this.formTemplate = 'projects/_form.tpl.html';
  }

  save() {
    this.resources.projects().create(this.project).then((project) => {
      this.project = project;
      this.$state.go("root.inner.project", {id: this.project.shortLink})
    });
  }
}
