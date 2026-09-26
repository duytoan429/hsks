-- ============================================================
-- SCHEMA CHO VMOS AUTO REGISTER
-- Chạy trong Supabase Dashboard -> SQL Editor
-- ============================================================

-- Xóa bảng cũ nếu tồn tại
DROP TABLE IF EXISTS registrations;

-- Tạo bảng lưu kết quả đăng ký
CREATE TABLE registrations (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    email TEXT NOT NULL,
    password TEXT NOT NULL,
    otp TEXT,
    service TEXT DEFAULT 'vmos',
    status TEXT DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index để tìm kiếm nhanh
CREATE INDEX idx_registrations_email ON registrations(email);
CREATE INDEX idx_registrations_created ON registrations(created_at DESC);

-- Bật Row Level Security
ALTER TABLE registrations ENABLE ROW LEVEL SECURITY;

-- Xóa policy cũ nếu có
DROP POLICY IF EXISTS "anon can read registrations" ON registrations;
DROP POLICY IF EXISTS "anon can insert registrations" ON registrations;
DROP POLICY IF EXISTS "anon can update registrations" ON registrations;

-- Cho phép anon đọc dữ liệu
CREATE POLICY "anon can read registrations"
ON registrations FOR SELECT
TO anon
USING (true);

-- Cho phép anon ghi dữ liệu
CREATE POLICY "anon can insert registrations"
ON registrations FOR INSERT
TO anon
WITH CHECK (true);

-- Cho phép anon cập nhật
CREATE POLICY "anon can update registrations"
ON registrations FOR UPDATE
TO anon
USING (true)
WITH CHECK (true);
