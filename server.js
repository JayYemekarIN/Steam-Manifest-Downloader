const express = require("express");
const axios = require("axios");

const app = express();
app.use(express.static("public"));

app.get("/download", async (req, res) => {
  const { branch } = req.query;

  if (!branch) {
    return res.status(400).send("Branch required");
  }

  const url = `https://github.com/SteamAutoCracks/ManifestHub/archive/refs/heads/${branch}.zip`;

  try {
    const response = await axios.get(url, { responseType: "stream" });

    res.setHeader("Content-Disposition", `attachment; filename=ManifestHub-${branch}.zip`);
    response.data.pipe(res);

  } catch (err) {
    return res.status(404).send("Branch not found or repo not accessible.");
  }
});

app.listen(3000, () => {
  console.log("Server running: http://localhost:3000");
});
