import RL from "relayer";
import {Module, Config, applyAnnotation} from "a1atscript";
import {backendUrl} from 'config';

class Project extends RL.Resource{}
RL.Describe(Project, (desc) => {
  desc.hasList("pledges", Pledge, []);
  desc.property("name", "");
  desc.property("description", "");
  desc.property("deadline", "");
  desc.property("goal", "");
});

class Pledge extends RL.Resource{}
RL.Describe(Pledge, (desc) => {
  desc.property("amount", "");
  desc.property("comment", "");
});

class Resources extends RL.Resource {
}

RL.Describe(Resources, (desc) => {
  // put top level links to resources here
  var projects = desc.hasList('projects', Project, []);
  projects.linkTemplate = "project";
  projects.canCreate = true;
  var project = desc.hasOne('project', Project);
  project.templated = true;

  var pledges = desc.hasList('pledges', Pledge, []);
  pledges.linkTemplate = "project_pledges";
  pledges.canCreate = true;
});

// sets up default API as 'resources' service
function setupResources(relayerProvider) {
  relayerProvider.createApi("resources", Resources, backendUrl+"resources")
}

// this is a syntax for applying an annotation without an ES7 Decorator
applyAnnotation(setupResources, Config, "relayerProvider");

var resourcesModule = new Module('xing.resources', [setupResources,
  RL]);

export default resourcesModule;
