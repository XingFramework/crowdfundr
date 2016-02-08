import {Controller} from 'a1atscript';

@Controller('HomepageShowCtrl', ['projects'])
export class HomepageShowController {
  constructor(projects) {
    this.projects = projects;
  }
}

@Controller('HomepageCtrl', [])
export class HomepageController {
  constructor() {}
}
