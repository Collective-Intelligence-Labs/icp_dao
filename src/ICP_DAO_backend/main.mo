import Array "mo:base/Array";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";

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
  };

  // Update DAO members
  private func updateMembers(candidates: [Principal]) {
    members := Array.filter(candidates, func(_: Principal) : Bool { true });
    emitMembersUpdated(members);
  }
}
