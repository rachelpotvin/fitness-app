# CheckIt Fitness App - Supabase Setup Guide

## Step 1: Create a Supabase Project

1. Go to [supabase.com](https://supabase.com) and sign up/login
2. Click "New Project"
3. Choose your organization
4. Enter project details:
   - Name: `checkit-fitness` (or any name you prefer)
   - Database Password: Choose a strong password
   - Region: Choose closest to you
5. Click "Create new project"
6. Wait for the project to be created (this takes a few minutes)

## Step 2: Get Your Project Credentials

1. In your Supabase dashboard, go to **Settings** → **API**
2. Copy your **Project URL** and **anon public** key
3. Replace the placeholders in `index.html`:
   ```javascript
   const SUPABASE_URL = 'https://ipvpgyihcgkgdahjbrtu.supabase.co'; // Replace with your Project URL
   const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlwdnBneWloY2drZ2RhaGpicnR1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY1ODkxNTMsImV4cCI6MjA3MjE2NTE1M30.0QtB9_7chU9eAFYmN3At4-4w76W4eA6UNMVYDyYLRCU'; // Replace with your anon key
   ```

## Step 3: Set Up the Database Schema

1. In your Supabase dashboard, go to **SQL Editor**
2. Copy the contents of `supabase-setup.sql`
3. Paste it into the SQL Editor
4. Click "Run" to execute the schema

This will create:
- `goals` table for storing your fitness goals
- `daily_checks` table for storing daily progress
- `user_targets` table for weekly/monthly targets
- Row Level Security policies to keep data private
- Indexes for better performance

## Step 4: Configure Authentication

1. Go to **Authentication** → **Settings**
2. Under "Site URL", add your domain (for local development, you can use `http://localhost:3000`)
3. Under "Redirect URLs", add your domain + `/index.html`

## Step 5: Test Your Setup

1. Open `index.html` in your browser
2. You should see a sign-in/sign-up form
3. Create an account with your email
4. Check your email for the confirmation link
5. Sign in and start using the app!

## Features Added

✅ **Cross-device sync** - Your data is now stored in the cloud  
✅ **User authentication** - Secure login with email/password  
✅ **Real-time updates** - Changes sync across devices  
✅ **Data privacy** - Row Level Security ensures only you can see your data  
✅ **Export/Import** - Still works for backups  
✅ **Offline support** - App works offline, syncs when online  

## Troubleshooting

### "Invalid API key" error
- Double-check your SupABASE_URL and SUPABASE_ANON_KEY
- Make sure you copied the "anon public" key, not the service role key

### "Row Level Security" error
- Make sure you ran the SQL schema in Step 3
- Check that RLS policies were created successfully

### Can't sign up/sign in
- Check your email for the confirmation link
- Verify your redirect URLs in Authentication settings
- Try clearing browser cache

### Data not syncing
- Check browser console for errors
- Verify your internet connection
- Make sure you're signed in

## Next Steps

Once everything is working, you can:

1. **Deploy to a web server** (Netlify, Vercel, GitHub Pages)
2. **Add real-time subscriptions** for live updates across devices
3. **Add social features** like sharing goals with friends
4. **Add data analytics** and progress charts

## Security Notes

- Your data is encrypted at rest and in transit
- Row Level Security ensures only you can access your data
- Supabase handles authentication securely
- You can export your data anytime for backup

## Cost

Supabase has a generous free tier:
- 500MB database
- 2GB bandwidth
- 50,000 monthly active users
- 500K Edge Function invocations

This should be more than enough for personal use! 