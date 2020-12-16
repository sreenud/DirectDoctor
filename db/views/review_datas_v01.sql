SELECT
  doctor_id,
  COUNT(*) as total,
  AVG(rating) as avg_rating
FROM reviews
GROUP BY doctor_id;
