import {Controller} from 'a1atscript';

@Controller('ProjectsCtrl', ['project'])
export class ProjectsController {
  constructor(project) {
    this.project = project;
  }
}

@Controller("ProjectNewCtrl", ["resources", "$state", "CurrentUser"])
export class ProjectNewController {
  constructor(resources, $state, currentUser) {
    this.resources = resources;
    this.$state = $state;
    this.currentUser = currentUser;
    this.project = this.resources.projects().new();
    this.formTemplate = 'projects/_form.tpl.html';
  }

  save() {
    this.project.userId = this.currentUser.user.id;
    this.resources.projects().create(this.project).then((project) => {
      this.project = project;
      this.$state.go("root.inner.project", {id: this.project.shortLink});
    });
  }
}
