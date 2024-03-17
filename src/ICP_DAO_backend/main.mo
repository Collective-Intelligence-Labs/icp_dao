import Principal "mo:base/Principal";
import Debug "mo:base/Debug";
import Random "mo:base/Random";
import Buffer "mo:base/Buffer";
import Option "mo:base/Option";
import Array "mo:base/Array";

actor SimpleDAO {
  // Use Principal to represent members
  var members : [Principal] = [];

  private func emitMembersUpdated(newMembers : [Principal]) {
    Debug.print(debug_show (newMembers));
  };

  // Receive a list of addresses and possibly create a DAO
  public func createDAOIfLucky(candidates : [Principal]) : async () {
    assert (candidates.size() > 0);

    var candidatesBuffer = Buffer.Buffer<Principal>(candidates.size());

    let random = Random.Finite(await Random.blob());
    // Proceed if double coin flip
    var shouldProceed : Bool = Option.get(random.coin(), false) and Option.get(random.coin(), false);

    if (shouldProceed) {
      var selectedCandidates: [Principal] = [];
      
      for (i in candidates.keys()) {
        let candidate = candidates[i];
        let coin = Option.get(random.coin(), false);
        if (coin) {
          candidatesBuffer.add(candidate);
        }
      };

      updateMembers(selectedCandidates);
    };
  };

  // Update DAO members
  private func updateMembers(candidates : [Principal]) {
    members := Array.filter(candidates, func(_ : Principal) : Bool { true });
    emitMembersUpdated(members);
  };

  public func getMemebers() : async [Principal] {
    return members;
  }
};
