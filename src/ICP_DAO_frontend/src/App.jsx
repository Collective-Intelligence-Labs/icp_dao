import { useState } from 'react';
import { Principal } from '@dfinity/principal';
import { ICP_DAO_backend } from 'declarations/ICP_DAO_backend';

function App() {
  const [candidates, setCandidates] = useState('');
  const [membersUpdated, setMembersUpdated] = useState(false);
  const [members, setMembers] = useState([]);

  const handleCandidatesSubmit = async (event) => {
    event.preventDefault();
    const candidatesArray = candidates.split(',').map(candidate => Principal.fromText(candidate.trim()));
    try {
      await ICP_DAO_backend.createDAOIfLucky(candidatesArray);
      const updatedMembers = await ICP_DAO_backend.getMembers(); // Assuming getMembers is a method that retrieves the current DAO members.
      console.log(updatedMembers);
      setMembers(updatedMembers);
      setMembersUpdated(true);
    } catch (error) {
      console.error("Failed to create DAO or update members:", error);
      setMembersUpdated(false);
    }
  };

  const handleCandidatesChange = (event) => {
    setCandidates(event.target.value);
    let c = candidates.split(',').map(candidate => Principal.fromText(candidate.trim()));
    console.log(c);
    setMembersUpdated(false); // Reset this flag when user changes input
  };

  return (
    <main>
      <img src="/logo2.svg" alt="DFINITY logo" />
      <br /><br />
      <form onSubmit={handleCandidatesSubmit}>
        <label htmlFor="candidates">Enter candidate Principals (comma separated): &nbsp;</label>
        <input 
          id="candidates" 
          type="text" 
          value={candidates} 
          onChange={handleCandidatesChange} 
          placeholder="principal1,principal2,..."
        />
        <button type="submit">Try Creating DAO</button>
      </form>
      {membersUpdated && (
        <section id="members">
          <h3>DAO Members:</h3>
          <ul>
            {members.map((member, index) => (
              <li key={index}>{member.toString()}</li>
            ))}
          </ul>
        </section>
      )}
    </main>
  );
}


export default App;
