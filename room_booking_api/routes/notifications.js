import express from "express";
import fs from "fs";
import path from "path";

const router = express.Router();
const dataPath = path.resolve("data/notifications.json");

router.get("/", (req, res) => {
  const data = JSON.parse(fs.readFileSync(dataPath));
  res.json(data);
});

router.post("/", (req, res) => {
  const { from, to, message } = req.body;
  const data = JSON.parse(fs.readFileSync(dataPath));

  const newNotification = {
    id: Date.now(),
    from,
    to,
    message,
    timestamp: new Date().toISOString(),
  };

  data.push(newNotification);
  fs.writeFileSync(dataPath, JSON.stringify(data, null, 2));
  res.status(201).json(newNotification);
});

export default router;
