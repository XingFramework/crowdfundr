import {Controller} from 'a1atscript';

@Controller('ProjectCtrl', ['project', 'pledges', '$state'])
export class ProjectController {
  constructor(project, pledges, $state) {
    this.project = project;
    this.pledges = pledges;
    this.$state = $state;
    this.formTemplate = 'projects/_form.tpl.html';
    this.isPledgeFormVisible = false;
    this.newPledge = this.pledges.new();
  }

  edit() {
    this.$state.go("root.inner.projectEdit", {id: this.project.shortLink});
  }

  showPledgeForm() {
    this.isPledgeFormVisible = true;
  }

  cancelPledge() {
    this.isPledgeFormVisible = false;
  }

  submitPledge() {
    //TODO: Not sure if we should manually modify private property 'links' here
    //TODO: Pledge amounts are not properly saving
    this.newPledge._links['project'] = this.project.url;
    this.pledges.push(this.newPledge);
    this.pledges.update();
  }
}

@Controller('ProjectEditCtrl', ['project', '$state'])
export class ProjectEditController{
  constructor(project, $state) {
    this.project = project;
    this.$state = $state;
    this.formTemplate = 'projects/_form.tpl.html';
    this.displayData();
  }

  save() {
    return this.project.update().then((project) => {
      this.project = project;
      this.displayData();
      this.$state.go("root.inner.project", {id: this.project.shortLink});
    });
  }

  displayData() {
    this.project.deadline = new Date(this.project.deadline);
    this.project.goal = Number(this.project.goal);
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
