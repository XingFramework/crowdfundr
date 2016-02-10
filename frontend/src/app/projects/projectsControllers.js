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
