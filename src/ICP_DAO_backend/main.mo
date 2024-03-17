import Array "mo:base/Array";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";
import Random "mo:base/Random";
import Sha256 "mo:sha2/Sha256";

actor SimpleDAO {
  // Use Principal to represent members
  var members: [Principal] = [];

  private func emitMembersUpdated(newMembers: [Principal]) {
    Debug.print(debug_show(newMembers));
  };

  // Receive a list of addresses and possibly create a DAO
  public func createDAOIfLucky(candidates: [Principal]) : async () {
    assert(candidates.size() > 0);

    // TODO: Generate random, check bits and if all good ==> proceed with upating dao memebers
    var candidatesHash: Blob = Sha256.fromBlob(await Random.blob());

    for (candidate in candidates) {
      candidatesHash := Sha256.fromBlob(Array.append<Blob>(candidatesHash, Principal.toBlob(candidate)));
    };

    let shouldProceed = candidatesHash % 2 == 0;

    let random = Random.Finite(await Random.blob());
    var selectedCandidates: [Principal] = [];
    if (shouldProceed) {
      for (candidate in candidates) {
        let selected = random.coin();
        if (selected) {
          selectedCandidates.append(candidate);
        };
      };

      updateMembers(selectedCandidates);
    };
  };

  // Update DAO members
  private func updateMembers(candidates: [Principal]) {
    members := Array.filter(candidates, func(_: Principal) : Bool { true });
    emitMembersUpdated(members);
  };
};
