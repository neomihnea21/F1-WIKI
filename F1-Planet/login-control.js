
const express = require('express'); 
const app = express(); 
app.all('*', (req, res) => { 
  res.status(404).send("404.html"); 
}); 
  
app.listen(3000, () => { 
  console.log('Server is up on port 3000'); 
}); 