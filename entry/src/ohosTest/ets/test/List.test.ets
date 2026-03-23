import RecommendTest from './Recommend.test'
import EntryAbilityTest from './EntryAbility.test'
import abilityTest from './Ability.test';

export default function testsuite() {
  abilityTest();
  EntryAbilityTest()
  RecommendTest()
}