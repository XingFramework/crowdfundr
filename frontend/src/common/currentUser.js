import {Service} from "a1atscript";

@Service('CurrentUser', ["$rootScope", "$auth"])
export default class CurrentUser {
  constructor($rootScope, $auth) {
    this.$rootScope = $rootScope;
    this.$auth = $auth;
    this.$auth.validateUser().then((user) => {
      this.user = user;
    });
    this.$rootScope.$on('auth:login-success', (ev, user) => {
      this.user = user;
    });
    this.$rootScope.$on('auth:logout-success', (ev, user) => {
      this.user = null;
    });
  }
}
