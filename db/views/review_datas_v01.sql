SELECT
  doctor_id,
  COUNT(*) as total,
  AVG(rating) as avg_rating
FROM reviews WHERE status='published'
GROUP BY doctor_id;
