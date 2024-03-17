import { useState } from 'react';
import { Principal } from '@dfinity/principal';
import { ICP_DAO_backend } from 'declarations/ICP_DAO_backend';

function App() {
  const [candidatePrincipals, setCandidatePrincipals] = useState('');
  const [status, setStatus] = useState('');

  const handleInputChange = (event) => {
    setCandidatePrincipals(event.target.value);
  };

  const createDAOIfLucky = async () => {
    try {
      const candidates = candidatePrincipals.split(',').map(Principal.fromText);
      await ICP_DAO_backend.createDAOIfLucky(candidates);
      setStatus('DAO creation attempted.');
    } catch (error) {
      console.error('Error calling createDAOIfLucky:', error);
      setStatus(`Error: ${error.message}`);
    }
  };

  return (
    <main>
       <div>
      <h1>Simple DAO Creator</h1>
      <input
        type="text"
        value={candidatePrincipals}
        onChange={handleInputChange}
        placeholder="Enter candidate principals separated by comma"
      />
      <button onClick={createDAOIfLucky}>Create DAO If Lucky</button>
      <p>{status}</p>
    </div>
    </main>
  );
}

export default App;
