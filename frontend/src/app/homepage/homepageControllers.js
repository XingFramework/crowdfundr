import {Controller} from 'a1atscript';

@Controller('HomepageShowCtrl', ['projects', 'CurrentUser'])
export class HomepageShowController {
  constructor(projects, currentUser) {
    this.projects = projects;
    this.currentUser = currentUser;
  }
}

@Controller('HomepageCtrl', [])
export class HomepageController {
  constructor() {}
}
