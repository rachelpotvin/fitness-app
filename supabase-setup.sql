-- Supabase Database Schema for CheckIt Fitness App
-- Run this in your Supabase SQL Editor

-- Create tables
CREATE TABLE IF NOT EXISTS public.goals (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    goal_id TEXT NOT NULL,
    name TEXT NOT NULL,
    points INTEGER NOT NULL DEFAULT 1,
    mode TEXT NOT NULL DEFAULT 'binary' CHECK (mode IN ('binary', 'count')),
    unit_label TEXT DEFAULT '',
    unit_size INTEGER DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, goal_id)
);

CREATE TABLE IF NOT EXISTS public.daily_checks (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    goal_id TEXT NOT NULL,
    value JSONB NOT NULL, -- Can be boolean or number
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, date, goal_id)
);

CREATE TABLE IF NOT EXISTS public.user_targets (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
    weekly_target INTEGER DEFAULT 20,
    monthly_target INTEGER DEFAULT 80,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_goals_user_id ON public.goals(user_id);
CREATE INDEX IF NOT EXISTS idx_daily_checks_user_id ON public.daily_checks(user_id);
CREATE INDEX IF NOT EXISTS idx_daily_checks_date ON public.daily_checks(date);
CREATE INDEX IF NOT EXISTS idx_user_targets_user_id ON public.user_targets(user_id);

-- Enable Row Level Security
ALTER TABLE public.goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_checks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_targets ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
-- Goals policies
CREATE POLICY "Users can view their own goals" ON public.goals
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own goals" ON public.goals
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own goals" ON public.goals
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own goals" ON public.goals
    FOR DELETE USING (auth.uid() = user_id);

-- Daily checks policies
CREATE POLICY "Users can view their own daily checks" ON public.daily_checks
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own daily checks" ON public.daily_checks
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own daily checks" ON public.daily_checks
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own daily checks" ON public.daily_checks
    FOR DELETE USING (auth.uid() = user_id);

-- User targets policies
CREATE POLICY "Users can view their own targets" ON public.user_targets
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own targets" ON public.user_targets
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own targets" ON public.user_targets
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own targets" ON public.user_targets
    FOR DELETE USING (auth.uid() = user_id);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_goals_updated_at BEFORE UPDATE ON public.goals
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_daily_checks_updated_at BEFORE UPDATE ON public.daily_checks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_targets_updated_at BEFORE UPDATE ON public.user_targets
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column(); 