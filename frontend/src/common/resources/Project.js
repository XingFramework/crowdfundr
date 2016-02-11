import RL from "relayer";

export default class Project extends RL.Resource{}
RL.Describe(Project, (desc) => {
  desc.property("name", "");
  desc.property("description", "");
  desc.property("deadline", "");
  desc.property("goal", "");
  desc.property("userId", 0);
});
