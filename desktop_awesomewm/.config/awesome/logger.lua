file = io.open(os.getenv("HOME") .. "/.config/awesome/log", "a")
logger = {
  DEBUG = "D",
  INFO = "I",
  WARN = "W",
  ERROR = "E"
}
function logger.log(tag, str, level)
  level = level or logger.INFO
  file:write(os.date() .. " " .. level .. " " .. tag .. ": " .. str, "\n")
end

return logger
