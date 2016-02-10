import {Controller} from 'a1atscript';

@Controller('ProjectsCtrl', ['project'])
export class ProjectsController {
  constructor(project) {
    this.project = project;
  }

  edit() {
    $state.go()
  }
}

@Controller('ProjectsEditCtrl', ['project'])
export class ProjectsEditCtrl{
  constructor(project) {
    this.project = project;
    this.formTemplate = 'projects/_form.tpl.html'
  }

  save() {
    this.project.update().then((project) => {
      this.project = project;
      return this.project;
    });
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
