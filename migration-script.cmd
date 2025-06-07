REM Checking the status of current and available migrations
.\vendor\bin\doctrine-migrations status
REM Running the available migrations with dry-run (un-committed mode)
.\vendor\bin\doctrine-migrations migrate --dry-run
REM Running the available migrations with commit mode
.\vendor\bin\doctrine-migrations migrate
