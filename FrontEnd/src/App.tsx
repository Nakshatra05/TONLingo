import React, { useState } from 'react';
import './App.css';

const App: React.FC = () => {
  const [points, setPoints] = useState(0);

  const handleRegister = () => {
    // Interact with the smart contract to register the user
    console.log('User registered');
  };

  const handleCheckPoints = () => {
    // Fetch user points from the smart contract
    setPoints(100); // Example points fetched
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>TONLingo</h1>
        <button onClick={handleRegister}>Register</button>
        <button onClick={handleCheckPoints}>Check Points</button>
        <p>You have {points} points.</p>
      </header>
    </div>
  );
}

export default App;
