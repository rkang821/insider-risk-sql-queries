-- Detect bulk downloads: users downloading more than @DOWNLOAD_THRESHOLD files in @TIME_WINDOW

SELECT
  user_email,
  window(timestamp, @TIME_WINDOW) AS time_window,
  COUNT(doc_id) AS download_count
FROM AUDIT_TABLE
WHERE event_type = 'download'
GROUP BY user_email, window(timestamp, @TIME_WINDOW)
HAVING COUNT(doc_id) > @DOWNLOAD_THRESHOLD
ORDER BY time_window DESC;