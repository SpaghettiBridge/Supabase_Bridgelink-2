

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pg_cron" WITH SCHEMA "pg_catalog";






CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."audit_student_admissions"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $_$
DECLARE
    col TEXT;
    old_value TEXT;
    new_value TEXT;
    error_message TEXT;
BEGIN
    -- Loop through each column in the table
    FOR col IN (SELECT column_name::TEXT 
                FROM information_schema.columns 
                WHERE table_name = 'student_admissions' 
                  AND table_schema = 'public')
    LOOP
        -- Safely get old and new values
        EXECUTE format('SELECT $1.%I::TEXT, $2.%I::TEXT', col, col)
        INTO old_value, new_value
        USING OLD, NEW;

        -- Check if the column value has changed
        IF OLD.id IS NOT NULL AND NEW.id IS NOT NULL AND OLD.id = NEW.id AND old_value IS DISTINCT FROM new_value THEN
            BEGIN
                INSERT INTO public.audit_log(
                    table_name, 
                    record_id, 
                    field_name, 
                    old_value, 
                    new_value, 
                    action, 
                    action_by,
                    student_id, -- Add student_id to the INSERT
                    service_id  -- Add service_id to the INSERT
                ) VALUES (
                    TG_TABLE_NAME,
                    OLD.id,
                    col,
                    old_value,
                    new_value,
                    TG_OP,
                    NEW.updated_by,
                    NEW.service_id,  -- Use the service_id from the student_admissions table
                    NEW.student_id  -- Use the student_id from the student_admissions table
                );
            EXCEPTION WHEN OTHERS THEN
                -- Log the error, but don't raise an exception
                GET STACKED DIAGNOSTICS error_message = MESSAGE_TEXT;
                INSERT INTO error_log (message) 
                VALUES (format('Error in audit_student_admissions trigger for column %s: %s', col, error_message));
            END;
        END IF;
    END LOOP;

    RETURN NEW;
EXCEPTION WHEN OTHERS THEN
    -- Log any unexpected errors
    GET STACKED DIAGNOSTICS error_message = MESSAGE_TEXT;
    INSERT INTO error_log (message) 
    VALUES (format('Unexpected error in audit_student_admissions trigger: %s', error_message));
    RETURN NEW;
END;
$_$;


ALTER FUNCTION "public"."audit_student_admissions"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."audit_student_records"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $_$
DECLARE
    col TEXT;
    old_value TEXT;
    new_value TEXT;
    error_message TEXT;
BEGIN
    -- Loop through each column in the table
    FOR col IN (SELECT column_name::TEXT 
                FROM information_schema.columns 
                WHERE table_name = 'student_records' 
                  AND table_schema = 'public')
    LOOP
        -- Safely get old and new values
        EXECUTE format('SELECT $1.%I::TEXT, $2.%I::TEXT', col, col)
        INTO old_value, new_value
        USING OLD, NEW;

        -- Check if the column value has changed
        IF OLD.id IS NOT NULL AND NEW.id IS NOT NULL AND OLD.id = NEW.id AND old_value IS DISTINCT FROM new_value THEN
            BEGIN
                INSERT INTO public.audit_log(
                    table_name, 
                    record_id, 
                    field_name, 
                    old_value, 
                    new_value, 
                    action, 
                    action_by,
                    student_id, -- Add student_id to the INSERT
                    service_id  -- Add service_id to the INSERT
                ) VALUES (
                    TG_TABLE_NAME,
                    OLD.id,
                    col,
                    old_value,
                    new_value,
                    TG_OP,
                    NEW.updated_by,
                    NEW.service_id,  -- Use the service_id from the student_records table
                    NEW.student_id  -- Use the student_id from the student_records table
                );
            EXCEPTION WHEN OTHERS THEN
                -- Log the error, but don't raise an exception
                GET STACKED DIAGNOSTICS error_message = MESSAGE_TEXT;
                INSERT INTO error_log (message) 
                VALUES (format('Error in audit_student_records trigger for column %s: %s', col, error_message));
            END;
        END IF;
    END LOOP;

    RETURN NEW;
EXCEPTION WHEN OTHERS THEN
    -- Log any unexpected errors
    GET STACKED DIAGNOSTICS error_message = MESSAGE_TEXT;
    INSERT INTO error_log (message) 
    VALUES (format('Unexpected error in audit_student_records trigger: %s', error_message));
    RETURN NEW;
END;
$_$;


ALTER FUNCTION "public"."audit_student_records"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."audit_student_relational"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $_$
DECLARE
    col TEXT;
    old_value TEXT;
    new_value TEXT;
    error_message TEXT;
BEGIN
    -- Loop through each column in the table
    FOR col IN (SELECT column_name::TEXT 
                FROM information_schema.columns 
                WHERE table_name = 'student_relational' 
                  AND table_schema = 'public')
    LOOP
        -- Safely get old and new values
        EXECUTE format('SELECT $1.%I::TEXT, $2.%I::TEXT', col, col)
        INTO old_value, new_value
        USING OLD, NEW;

        -- Check if the column value has changed
        IF OLD.id IS NOT NULL AND NEW.id IS NOT NULL AND OLD.id = NEW.id AND old_value IS DISTINCT FROM new_value THEN
            BEGIN
                INSERT INTO public.audit_log(
                    table_name, 
                    record_id, 
                    field_name, 
                    old_value, 
                    new_value, 
                    action, 
                    action_by,
                    student_id, -- Add student_id to the INSERT
                    service_id  -- Add service_id to the INSERT
                ) VALUES (
                    TG_TABLE_NAME,
                    OLD.id,
                    col,
                    old_value,
                    new_value,
                    TG_OP,
                    NEW.updated_by,
                    NEW.service_id,  -- Use the service_id from the student_relational table
                    NEW.student_id  -- Use the student_id from the student_relational table
                );
            EXCEPTION WHEN OTHERS THEN
                -- Log the error, but don't raise an exception
                GET STACKED DIAGNOSTICS error_message = MESSAGE_TEXT;
                INSERT INTO error_log (message) 
                VALUES (format('Error in audit_student_relational trigger for column %s: %s', col, error_message));
            END;
        END IF;
    END LOOP;

    RETURN NEW;
EXCEPTION WHEN OTHERS THEN
    -- Log any unexpected errors
    GET STACKED DIAGNOSTICS error_message = MESSAGE_TEXT;
    INSERT INTO error_log (message) 
    VALUES (format('Unexpected error in audit_student_relational trigger: %s', error_message));
    RETURN NEW;
END;
$_$;


ALTER FUNCTION "public"."audit_student_relational"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."audit_students"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $_$
DECLARE
    col TEXT;
    old_value TEXT;
    new_value TEXT;
    error_message TEXT;
BEGIN
    -- Loop through each column in the table
    FOR col IN (SELECT column_name::TEXT 
                FROM information_schema.columns 
                WHERE table_name = 'students' 
                  AND table_schema = 'public')
    LOOP
        -- Safely get old and new values
        EXECUTE format('SELECT $1.%I::TEXT, $2.%I::TEXT', col, col)
        INTO old_value, new_value
        USING OLD, NEW;

        -- Check if the column value has changed
        IF OLD.id IS NOT NULL AND NEW.id IS NOT NULL AND OLD.id = NEW.id AND old_value IS DISTINCT FROM new_value THEN
            BEGIN
                INSERT INTO public.audit_log(
                    table_name, 
                    record_id, 
                    field_name, 
                    old_value, 
                    new_value, 
                    action, 
                    action_by,
                    student_id, -- Add student_id to the INSERT
                    service_id  -- Add service_id to the INSERT
                ) VALUES (
                    TG_TABLE_NAME,
                    OLD.id,
                    col,
                    old_value,
                    new_value,
                    TG_OP,
                    NEW.updated_by,
                    NEW.service_id,  -- Use the service_id from the students table
                    NEW.id  -- Use the student_id from the students table
                );
            EXCEPTION WHEN OTHERS THEN
                -- Log the error, but don't raise an exception
                GET STACKED DIAGNOSTICS error_message = MESSAGE_TEXT;
                INSERT INTO error_log (message) 
                VALUES (format('Error in audit_students trigger for column %s: %s', col, error_message));
            END;
        END IF;
    END LOOP;

    RETURN NEW;
EXCEPTION WHEN OTHERS THEN
    -- Log any unexpected errors
    GET STACKED DIAGNOSTICS error_message = MESSAGE_TEXT;
    INSERT INTO error_log (message) 
    VALUES (format('Unexpected error in audit_students trigger: %s', error_message));
    RETURN NEW;
END;
$_$;


ALTER FUNCTION "public"."audit_students"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."auto_set_all_day"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NEW.start_time IS NULL AND NEW.end_time IS NULL THEN
        NEW.all_day := TRUE;
    ELSE
        NEW.all_day := FALSE;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."auto_set_all_day"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."calculate_admission_status"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  NEW.status := 
    CASE
      WHEN NEW.start_date <= CURRENT_DATE AND (NEW.end_date IS NULL OR NEW.end_date > CURRENT_DATE) THEN 'On Roll'
      WHEN NEW.end_date IS NOT NULL AND NEW.end_date <= CURRENT_DATE THEN 'Off Roll'
      WHEN NEW.start_date > CURRENT_DATE THEN 'Pending'
      ELSE 'Unknown'
    END;
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."calculate_admission_status"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."calculate_age"("birth_date" "date") RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN DATE_PART('year', AGE(CURRENT_DATE, birth_date));
END;
$$;


ALTER FUNCTION "public"."calculate_age"("birth_date" "date") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."calculate_next_active_date"("p_start_date" "date", "p_interval_days" integer) RETURNS "date"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    v_current_date DATE := p_start_date;
    v_days_counted INTEGER := 0;
    v_next_week weeks%ROWTYPE;
BEGIN
    WHILE v_days_counted < p_interval_days LOOP
        -- Find the next week that starts on or after the current date
        SELECT * INTO v_next_week
        FROM weeks
        WHERE week_start >= v_current_date
        ORDER BY week_start
        LIMIT 1;

        IF NOT FOUND THEN
            -- If no more weeks found, break the loop
            EXIT;
        END IF;

        -- If there's a gap, move to the start of the next week
        v_current_date := GREATEST(v_current_date, v_next_week.week_start);

        -- Calculate how many days we can count in this week
        v_days_counted := v_days_counted + LEAST(
            p_interval_days - v_days_counted,
            v_next_week.week_end - v_current_date + 1
        );

        -- Move to the next day
        v_current_date := v_current_date + (v_days_counted - (v_days_counted / 7 * 7))::INTEGER;
    END LOOP;

    RETURN v_current_date;
END;
$$;


ALTER FUNCTION "public"."calculate_next_active_date"("p_start_date" "date", "p_interval_days" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."check_and_upsert_student_tag"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Check if an active tag with the same short_tag already exists for this student and service
    IF EXISTS (
        SELECT 1
        FROM public.student_tags
        WHERE student_id = NEW.student_id
        AND service_id = NEW.service_id
        AND short_tag = NEW.short_tag
        AND status = 'active'
        AND id != COALESCE(NEW.id, '00000000-0000-0000-0000-000000000000'::uuid)
    ) THEN
        RAISE EXCEPTION 'An active tag with this short_tag already exists for this student and service.';
    END IF;

    -- If we're here, it means we can proceed with the insert or update
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."check_and_upsert_student_tag"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."check_is_local_authority"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM organisations WHERE id = NEW.organisation_id AND is_local_authority = TRUE) THEN
        RAISE EXCEPTION 'Organisation must be marked as a local authority';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."check_is_local_authority"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."check_risk_level"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
   -- If record_type is not Incident or Safeguarding, set risk_level to NULL
   IF NEW.record_type NOT IN ('Incident', 'Safeguarding') THEN
       UPDATE student_records
       SET risk_level = NULL
       WHERE id = NEW.id
       AND record_type NOT IN ('Incident', 'Safeguarding')
       AND risk_level IS NOT NULL;
   END IF;
   
   RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."check_risk_level"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_link_records"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- Set the custom setting at the beginning of the function
  PERFORM set_config('my.function_name', 'create_link_records', true);
  
  -- Your existing function logic here
  -- ...

  -- Clear the custom setting at the end of the function
  PERFORM set_config('my.function_name', NULL, true);
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."create_link_records"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_student_event_with_followups"("p_student_id" "uuid", "p_service_id" "uuid", "p_template_id" "uuid", "p_start_date" "date") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    v_template event_templates%ROWTYPE;
    v_follow_up event_follow_ups%ROWTYPE;
    v_end_date DATE;
    v_parent_event_id UUID;
BEGIN
    -- Start the transaction
    BEGIN
        -- Get the template details
        SELECT * INTO v_template FROM event_templates WHERE id = p_template_id;
        
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Template with ID % not found', p_template_id;
        END IF;
        
        -- Calculate end date for the main event
        v_end_date := calculate_next_active_date(p_start_date, v_template.interval_days);
        
        -- Insert the main event
        INSERT INTO student_events (
            student_id, service_id, template_id, start_date, end_date,
            title, description, status
        ) VALUES (
            p_student_id, p_service_id, p_template_id, p_start_date, v_end_date,
            COALESCE(v_template.name, 'Untitled Event'), 
            COALESCE(v_template.description, ''),
            'active'
        ) RETURNING id INTO v_parent_event_id;
        
        -- Create follow-up events
        FOR v_follow_up IN (
            SELECT * FROM event_follow_ups
            WHERE template_id = p_template_id
            ORDER BY follow_up_order
        )
        LOOP
            -- Calculate start_date for follow-up event
            v_end_date := calculate_next_active_date(p_start_date, v_follow_up.interval_days);
            
            INSERT INTO student_events (
                student_id, service_id, template_id, parent_event_id,
                follow_up_order, start_date, end_date, title, description, status
            ) VALUES (
                p_student_id, p_service_id, p_template_id, v_parent_event_id,
                v_follow_up.follow_up_order, v_end_date, v_end_date,
                COALESCE(v_follow_up.name, 'Untitled Follow-up'),
                COALESCE(v_follow_up.description, ''),
                'active'
            );
        END LOOP;

        -- If we get here, all operations were successful, so commit the transaction
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- If an error occurs, roll back all changes
            ROLLBACK;
            -- Re-raise the error to the caller
            RAISE;
    END;
END;
$$;


ALTER FUNCTION "public"."create_student_event_with_followups"("p_student_id" "uuid", "p_service_id" "uuid", "p_template_id" "uuid", "p_start_date" "date") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."determine_term_and_academic_year"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Find the matching term and set term_id and academic_year_id
    SELECT terms.id, terms.academic_year_id
    INTO NEW.term_id, NEW.academic_year_id
    FROM terms
    WHERE NEW.date BETWEEN terms.start_date AND terms.end_date
      AND terms.status = 'active'
    ORDER BY terms.sorting
    LIMIT 1;

    -- If no matching term found, set to NULL or handle as needed
    IF NEW.term_id IS NULL THEN
        NEW.term_id := NULL;
        NEW.academic_year_id := NULL;
        -- Optionally, raise an exception or log a warning
        -- RAISE WARNING 'No matching term found for date %', NEW.date;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."determine_term_and_academic_year"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."format_interval_display"("p_interval" interval) RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN EXTRACT(DAY FROM p_interval)::TEXT || ' days';
END;
$$;


ALTER FUNCTION "public"."format_interval_display"("p_interval" interval) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."generate_daily_attendance_records"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    current_date DATE := CURRENT_DATE;
    current_term RECORD;
    current_week RECORD;
BEGIN
    -- Check if today is a weekday (1-5 represents Monday to Friday)
    IF EXTRACT(DOW FROM current_date) NOT IN (0, 6) THEN
        -- Find the current term and week
        SELECT t.*, w.id AS week_id
        INTO current_term
        FROM terms t
        JOIN weeks w ON w.term_id = t.id
        WHERE current_date BETWEEN t.start_date AND t.end_date
          AND current_date BETWEEN w.week_start AND w.week_end
        LIMIT 1;

        -- If we're in a term and week, create attendance records
        IF FOUND THEN
            -- Insert AM records
            INSERT INTO student_attendance (student_id, service_id, term_id, week_id, date, session)
            SELECT 
                sa.student_id,
                sa.service_id,
                current_term.id,
                current_term.week_id,
                current_date,
                'AM'
            FROM student_admissions sa
            WHERE sa.status = 'On Roll'
              AND NOT EXISTS (
                  SELECT 1
                  FROM student_attendance att
                  WHERE att.student_id = sa.student_id
                    AND att.date = current_date
                    AND att.session = 'AM'
              );

            -- Insert PM records
            INSERT INTO student_attendance (student_id, service_id, term_id, week_id, date, session)
            SELECT 
                sa.student_id,
                sa.service_id,
                current_term.id,
                current_term.week_id,
                current_date,
                'PM'
            FROM student_admissions sa
            WHERE sa.status = 'On Roll'
              AND NOT EXISTS (
                  SELECT 1
                  FROM student_attendance att
                  WHERE att.student_id = sa.student_id
                    AND att.date = current_date
                    AND att.session = 'PM'
              );
        END IF;
    END IF;
END;
$$;


ALTER FUNCTION "public"."generate_daily_attendance_records"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."generate_date_series"("start_date" "date", "end_date" "date") RETURNS TABLE("date" "date")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY SELECT generate_series(start_date, end_date, '1 day'::interval)::date;
END;
$$;


ALTER FUNCTION "public"."generate_date_series"("start_date" "date", "end_date" "date") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."generate_lookup"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Generate the serial number
    NEW.serial_no := nextval('public.student_records_serial_seq');

    -- Generate the lookup field only if it's not already set
    IF NEW.lookup IS NULL OR NEW.lookup = '' THEN
        NEW.lookup := NEW.record_type || '-' || LPAD(NEW.serial_no::text, 6, '0');
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."generate_lookup"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."generate_random_color"() RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    chars TEXT := '0123456789ABCDEF';
    result TEXT := '#';
    i INTEGER;
BEGIN
    FOR i IN 1..6 LOOP
        result := result || substr(chars, floor(random() * 16)::int + 1, 1);
    END LOOP;
    RETURN result;
END;
$$;


ALTER FUNCTION "public"."generate_random_color"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."generate_student_record_lookup"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Generate the serial number
    NEW.serial_no := nextval('public.student_records_serial_seq');

    -- Generate the lookup field only if it's not already set
    IF NEW.lookup IS NULL OR NEW.lookup = '' THEN
        NEW.lookup := NEW.record_type || '-' || NEW.serial_no::text;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."generate_student_record_lookup"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."generate_test_attendance_records"("p_service_id" "uuid", "p_term_id" "uuid") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    week_record RECORD;
    current_day DATE;
BEGIN
    -- Loop through each week for the given term
    FOR week_record IN (
        SELECT id, week_start, week_end
        FROM public.weeks
        WHERE term_id = p_term_id
        ORDER BY week_start
    )
    LOOP
        -- Initialize current_day for each week
        current_day := week_record.week_start;
        
        WHILE current_day <= week_record.week_end LOOP
            -- Skip weekends
            IF EXTRACT(DOW FROM current_day) NOT IN (0, 6) THEN
                -- Insert AM records
                INSERT INTO public.student_attendance (student_id, service_id, term_id, week_id, date, session)
                SELECT 
                    sa.student_id,
                    sa.service_id,
                    p_term_id,
                    week_record.id,
                    current_day,
                    'AM'
                FROM public.student_admissions sa
                WHERE sa.service_id = p_service_id
                  AND sa.status = 'On Roll'
                  AND NOT EXISTS (
                      SELECT 1
                      FROM public.student_attendance att
                      WHERE att.student_id = sa.student_id
                        AND att.date = current_day
                        AND att.session = 'AM'
                  );

                -- Insert PM records
                INSERT INTO public.student_attendance (student_id, service_id, term_id, week_id, date, session)
                SELECT 
                    sa.student_id,
                    sa.service_id,
                    p_term_id,
                    week_record.id,
                    current_day,
                    'PM'
                FROM public.student_admissions sa
                WHERE sa.service_id = p_service_id
                  AND sa.status = 'On Roll'
                  AND NOT EXISTS (
                      SELECT 1
                      FROM public.student_attendance att
                      WHERE att.student_id = sa.student_id
                        AND att.date = current_day
                        AND att.session = 'PM'
                  );
            END IF;

            current_day := current_day + INTERVAL '1 day';
        END LOOP;
    END LOOP;
END;
$$;


ALTER FUNCTION "public"."generate_test_attendance_records"("p_service_id" "uuid", "p_term_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."generate_weeks_for_academic_year"("p_academic_year_id" "uuid") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
    term_record RECORD;
    current_week_start DATE;
    current_week_end DATE;
    week_count INTEGER;
BEGIN
    -- Loop through each term in the specified academic year
    FOR term_record IN 
        SELECT id, start_date, end_date
        FROM public.terms 
        WHERE academic_year_id = p_academic_year_id  -- Use p_academic_year_id instead of $1
        ORDER BY start_date  -- Ensure terms are processed in chronological order
    LOOP
        -- Set the initial week start to the term start date
        current_week_start := term_record.start_date;
        week_count := 1;

        -- Continue until we've reached the end of the term
        WHILE current_week_start <= term_record.end_date LOOP
            -- Calculate the end of the current week (Friday or term end date, whichever comes first)
            current_week_end := LEAST(
                CASE 
                    WHEN EXTRACT(DOW FROM current_week_start) <= 5 THEN
                        current_week_start + (5 - EXTRACT(DOW FROM current_week_start))::INTEGER
                    ELSE
                        current_week_start + (5 + (7 - EXTRACT(DOW FROM current_week_start)))::INTEGER
                END,
                term_record.end_date
            );

            -- Insert a new week record
            INSERT INTO public.weeks (week_number, term_id, week_start, week_end, week_name)
            VALUES (
                week_count,
                term_record.id,
                current_week_start,
                current_week_end,
                'Wk ' || week_count
            )
            ON CONFLICT (term_id, week_number) DO UPDATE
            SET 
                week_start = EXCLUDED.week_start,
                week_end = EXCLUDED.week_end,
                week_name = EXCLUDED.week_name;

            -- Move to the next week (start on next weekday)
            current_week_start := current_week_end + 
                CASE 
                    WHEN EXTRACT(DOW FROM current_week_end) < 5 THEN 1  -- If not Friday, move to next day
                    ELSE (8 - EXTRACT(DOW FROM current_week_end))::INTEGER  -- If Friday or weekend, move to next Monday
                END;
            week_count := week_count + 1;

            -- Break the loop if we've moved past the term end date
            EXIT WHEN current_week_start > term_record.end_date;
        END LOOP;
    END LOOP;
END;
$_$;


ALTER FUNCTION "public"."generate_weeks_for_academic_year"("p_academic_year_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_service_attendance_by_code"("p_service_id" "uuid", "p_start_date" "date", "p_end_date" "date") RETURNS TABLE("short_code" character, "description" "text", "count" integer, "percentage" numeric)
    LANGUAGE "plpgsql"
    AS $$DECLARE
  total_sessions INTEGER;
BEGIN
  -- Calculate total number of sessions
  SELECT COUNT(*) INTO total_sessions
  FROM student_attendance ar
  WHERE ar.service_id = p_service_id
    AND ar.date BETWEEN p_start_date AND p_end_date;

  RETURN QUERY
  SELECT
    lac.short_code,
    lac.description,
    COUNT(*) AS count,
    ROUND((COUNT(*)::NUMERIC / NULLIF(total_sessions, 0)) * 100, 2) AS percentage
  FROM
    attendance_records ar
  JOIN
    lu_attendance_codes lac ON ar.attendance_code_id = lac.id
  WHERE
    ar.service_id = p_service_id
    AND ar.date BETWEEN p_start_date AND p_end_date
  GROUP BY
    lac.short_code, lac.description
  ORDER BY
    count DESC;
END;$$;


ALTER FUNCTION "public"."get_service_attendance_by_code"("p_service_id" "uuid", "p_start_date" "date", "p_end_date" "date") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_service_attendance_stats"("p_service_id" "uuid", "p_start_date" "date", "p_end_date" "date") RETURNS TABLE("attendance_type" "text", "count" integer, "percentage" numeric)
    LANGUAGE "plpgsql"
    AS $$DECLARE
  total_sessions INTEGER;
BEGIN
  -- Calculate total number of sessions
  SELECT COUNT(*) INTO total_sessions
  FROM student_attendance ar
  WHERE ar.service_id = p_service_id
    AND ar.date BETWEEN p_start_date AND p_end_date;

  RETURN QUERY
  SELECT
    attendance_type,
    count,
    ROUND((count::NUMERIC / NULLIF(total_sessions, 0)) * 100, 2) AS percentage
  FROM (
    SELECT
      CASE
        WHEN lac.present THEN 'Present'
        WHEN lac.authorised THEN 'Authorised Absence'
        WHEN lac.unauthorised THEN 'Unauthorised Absence'
        WHEN lac.admin THEN 'Admin'
        ELSE 'Other'
      END AS attendance_type,
      COUNT(*) AS count
    FROM
      student_attendance ar
    JOIN
      lu_attendance_codes lac ON ar.attendance_code_id = lac.id
    WHERE
      ar.service_id = p_service_id
      AND ar.date BETWEEN p_start_date AND p_end_date
    GROUP BY
      attendance_type
  ) subquery;
END;$$;


ALTER FUNCTION "public"."get_service_attendance_stats"("p_service_id" "uuid", "p_start_date" "date", "p_end_date" "date") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_empty_dates"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.start_date = NULLIF(NEW.start_date::text, '')::date;
    NEW.end_date = NULLIF(NEW.end_date::text, '')::date;
    NEW.dob = NULLIF(NEW.dob::text, '')::date;
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_empty_dates"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_student_admission_current_flag"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- If this is a new current admission or updating to current
    IF (TG_OP = 'INSERT' AND NEW.is_current = true) OR 
       (TG_OP = 'UPDATE' AND NEW.is_current = true AND (OLD.is_current = false OR OLD.is_current IS NULL)) THEN
        -- Set all other admissions for this student to not current (across ALL services)
        UPDATE public.student_admissions
        SET is_current = false
        WHERE student_id = NEW.student_id 
        AND id != NEW.id
        AND is_current = true;
    END IF;

    -- Validate that student_id and service_id match an existing student record
    IF NOT EXISTS (
        SELECT 1 FROM public.students 
        WHERE id = NEW.student_id 
        AND service_id = NEW.service_id
    ) THEN
        RAISE EXCEPTION 'Student ID % does not exist in service %', NEW.student_id, NEW.service_id;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_student_admission_current_flag"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."has_service_access"("service_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 
    FROM user_services 
    WHERE user_id = auth.uid() 
      AND service_id = service_id
  );
END;
$$;


ALTER FUNCTION "public"."has_service_access"("service_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."http_request"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$DECLARE
        request_id bigint;
        payload jsonb;
        url text := TG_ARGV[0]::text;
        method text := TG_ARGV[1]::text;
        headers jsonb DEFAULT '{}'::jsonb;
        params jsonb DEFAULT '{}'::jsonb;
        timeout_ms integer DEFAULT 1000;
      BEGIN
        IF url IS NULL OR url = 'null' THEN
          RAISE EXCEPTION 'url argument is missing';
        END IF;

        IF method IS NULL OR method = 'null' THEN
          RAISE EXCEPTION 'method argument is missing';
        END IF;

        IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
          headers = '{"Content-Type": "application/json"}'::jsonb;
        ELSE
          headers = TG_ARGV[2]::jsonb;
        END IF;

        IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
          params = '{}'::jsonb;
        ELSE
          params = TG_ARGV[3]::jsonb;
        END IF;

        IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
          timeout_ms = 1000;
        ELSE
          timeout_ms = TG_ARGV[4]::integer;
        END IF;

        CASE
          WHEN method = 'GET' THEN
            SELECT http_get INTO request_id FROM net.http_get(
              url,
              params,
              headers,
              timeout_ms
            );
          WHEN method = 'POST' THEN
            payload = jsonb_build_object(
              'old_record', OLD,
              'record', NEW,
              'type', TG_OP,
              'table', TG_TABLE_NAME,
              'schema', TG_TABLE_SCHEMA
            );

            SELECT http_post INTO request_id FROM net.http_post(
              url,
              payload,
              params,
              headers,
              timeout_ms
            );
          ELSE
            RAISE EXCEPTION 'method argument % is invalid', method;
        END CASE;

        /*
        INSERT INTO supabase_functions.hooks
          (hook_table_id, hook_name, request_id)
        VALUES
          (TG_RELID, TG_NAME, request_id);
        */
        
        RETURN NEW;
      END$$;


ALTER FUNCTION "public"."http_request"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."x_import_students" (
    "FullName" "text",
    "FullName : Title" "text",
    "FullName : First" "text",
    "FullName : Middle" "text",
    "FullName : Last" "text",
    "Initials" "text",
    "Service" "text",
    "Group" "text",
    "Context" "text",
    "HealthNeeds" "text",
    "Status" "text",
    "AP" "text",
    "APType" "text",
    "ISP" "text",
    "bLAC" "text",
    "bCPP" "text",
    "bCiN" "text",
    "bTAF" "text",
    "bMedia consent" "text",
    "dStudentName" "text",
    "AutoIncrement" bigint NOT NULL,
    "EntryID" bigint,
    "bUpdate" "text",
    "CountNeeds" bigint,
    "CountOutcomes" bigint,
    "CountNeedsCard" "text",
    "dSmallInitials" "text",
    "dColour" "text",
    "dInitials" "text",
    "PEEP" "text",
    "MedicalConsent" "text",
    "Medication" "text",
    "supabase_id" "uuid",
    "service_supabase_id" "text",
    "Count Assessments" "text",
    "StartDate" "date",
    "EndDate" "date",
    "DOB" "date",
    "Status\" "text"
);


ALTER TABLE "public"."x_import_students" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."import_student"("import_record" "public"."x_import_students") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    v_service_id uuid;
    v_student_id uuid;
BEGIN
    -- Get service_id
    SELECT id INTO v_service_id FROM services WHERE name = import_record."Service";
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Service not found: %', import_record."Service";
    END IF;

    -- Check if student exists
    IF import_record.supabase_id IS NOT NULL THEN
        -- Check by supabase_id
        SELECT id INTO v_student_id FROM students WHERE id = import_record.supabase_id::uuid;
    END IF;

    IF v_student_id IS NULL THEN
        -- Check by name and service
        SELECT id INTO v_student_id 
        FROM students 
        WHERE name = import_record."FullName"
          AND service_id = v_service_id;
    END IF;

    -- Insert or update student
    IF v_student_id IS NULL THEN
        INSERT INTO students (id, name, service_id, initials, first_name, middle_name, surname)
        VALUES (
            COALESCE(import_record.supabase_id::uuid, extensions.uuid_generate_v4()),
            import_record."FullName",
            v_service_id,
            import_record."Initials",
            import_record."FullName : First",
            import_record."FullName : Middle",
            import_record."FullName : Last"
        )
        RETURNING id INTO v_student_id;
    END IF;

    -- Insert student admission
    INSERT INTO student_admissions (
        service_id, student_id, start_date, end_date, dob
    ) VALUES (
        v_service_id,
        v_student_id,
        import_record."StartDate",
        import_record."EndDate",
        import_record."DOB"
    );

END;
$$;


ALTER FUNCTION "public"."import_student"("import_record" "public"."x_import_students") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."insert_user_service"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$BEGIN
  insert into user_services
  (user_id, service_id, status)
  select ur."userId",
  new.id,
  'active'
  from user_roles ur
  inner join lu_roles r on ur."roleId" = r.id
  where r.name in ('IT Team', 'IT Support');
END;$$;


ALTER FUNCTION "public"."insert_user_service"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."normalize_student_name"("name" "text") RETURNS "text"
    LANGUAGE "plpgsql" IMMUTABLE
    AS $$
BEGIN
  RETURN LOWER(TRIM(name));
END;
$$;


ALTER FUNCTION "public"."normalize_student_name"("name" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."populate_student_event_details"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    v_template event_templates%ROWTYPE;
    v_follow_up event_follow_ups%ROWTYPE;
BEGIN
    -- Get the template details
    SELECT * INTO v_template FROM event_templates WHERE id = NEW.template_id;
    
    IF FOUND THEN
        -- Update the main event's end date, title, and description
        UPDATE student_events
        SET 
            end_date = calculate_next_active_date(NEW.start_date, v_template.interval_days),
            title = COALESCE(NEW.title, v_template.name, 'Untitled Event'),
            description = COALESCE(NEW.description, v_template.description, '')
        WHERE id = NEW.id;

        -- Only create follow-ups for the main event (not for follow-ups themselves)
        IF NEW.parent_event_id IS NULL AND v_template.has_follow_ups THEN
            -- Create follow-up events
            FOR v_follow_up IN (
                SELECT * FROM event_follow_ups
                WHERE template_id = NEW.template_id
                ORDER BY follow_up_order
            )
            LOOP
                INSERT INTO student_events (
                    student_id, service_id, template_id, parent_event_id,
                    follow_up_order, start_date, end_date, title, description, status
                ) VALUES (
                    NEW.student_id, NEW.service_id, NEW.template_id, NEW.id,
                    v_follow_up.follow_up_order, 
                    calculate_next_active_date(NEW.start_date, v_follow_up.interval_days),
                    calculate_next_active_date(NEW.start_date, v_follow_up.interval_days),
                    v_follow_up.name, v_follow_up.description, 'active'
                );
            END LOOP;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."populate_student_event_details"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."remove_nulls_from_jsonb"("data" "jsonb") RETURNS "jsonb"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN (
        SELECT jsonb_object_agg(key, value)
        FROM jsonb_each(data)
        WHERE value != 'null'::jsonb
    );
END;
$$;


ALTER FUNCTION "public"."remove_nulls_from_jsonb"("data" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."scheduled_generate_attendance_records"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  PERFORM generate_daily_attendance_records();
END;
$$;


ALTER FUNCTION "public"."scheduled_generate_attendance_records"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_student_color"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.color_code := generate_random_color();
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."set_student_color"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_student_records_academic_year_and_term"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    v_academic_year_id UUID;
    v_term_id UUID;
    v_log_message TEXT;
BEGIN
    -- Get the current academic_year_id and term_id from the globals table
    SELECT current_academic_year, current_term
    INTO v_academic_year_id, v_term_id
    FROM globals
    LIMIT 1;

    -- If we couldn't get the values from globals, log an error
    IF v_academic_year_id IS NULL OR v_term_id IS NULL THEN
        v_log_message := 'Error: Could not retrieve current academic year or term from globals table for student record ID ' || NEW.id;
        RAISE WARNING '%', v_log_message;
        INSERT INTO error_log (message) VALUES (v_log_message);
        RETURN NEW; -- Still return NEW to allow the insert to complete
    END IF;

    -- Update the newly inserted record with academic_year_id and term_id
    UPDATE student_records
    SET academic_year_id = v_academic_year_id,
        term_id = v_term_id
    WHERE id = NEW.id;

    -- Log successful update
    v_log_message := 'Successfully set academic_year_id and term_id for student record ID ' || NEW.id;
    RAISE NOTICE '%', v_log_message;
    INSERT INTO error_log (message) VALUES (v_log_message);

    RETURN NEW;
EXCEPTION WHEN OTHERS THEN
    -- Log any unexpected errors
    v_log_message := 'Error in set_student_records_academic_year_and_term function for record ID ' || NEW.id || ': ' || SQLERRM;
    RAISE WARNING '%', v_log_message;
    INSERT INTO error_log (message) VALUES (v_log_message);
    RETURN NEW; -- Still return NEW to ensure the original insert is not affected
END;
$$;


ALTER FUNCTION "public"."set_student_records_academic_year_and_term"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."standardize_student_names"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Trim whitespace from names
  NEW.first_name = TRIM(NEW.first_name);
  NEW.surname = TRIM(NEW.surname);
  
  -- Handle middle name if present
  IF NEW.middle_name IS NOT NULL THEN
    NEW.middle_name = TRIM(NEW.middle_name);
    -- Set to NULL if empty after trimming
    IF NEW.middle_name = '' THEN
      NEW.middle_name = NULL;
    END IF;
  END IF;
  
  -- Handle preferred name if present
  IF NEW.preferred_name IS NOT NULL THEN
    NEW.preferred_name = TRIM(NEW.preferred_name);
    -- Set to NULL if empty after trimming
    IF NEW.preferred_name = '' THEN
      NEW.preferred_name = NULL;
    END IF;
  END IF;
  
  -- Update the name field to match the calculated format
  NEW.name = CASE 
    WHEN NEW.preferred_name IS NOT NULL AND NEW.preferred_name != '' 
    THEN NEW.preferred_name || ' ' || NEW.surname
    ELSE NEW.first_name || ' ' || NEW.surname
  END;
  
  -- Update initials
  NEW.initials = UPPER(LEFT(NEW.first_name, 1) || LEFT(NEW.surname, 1));
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."standardize_student_names"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."trigger_update_admission_status_daily"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  PERFORM update_admission_status_daily();
  RETURN NULL;
END;
$$;


ALTER FUNCTION "public"."trigger_update_admission_status_daily"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_admission_status_daily"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  UPDATE public.student_admissions
  SET status = 
    CASE
      WHEN start_date <= CURRENT_DATE AND (end_date IS NULL OR end_date > CURRENT_DATE) THEN 'On Roll'
      WHEN end_date IS NOT NULL AND end_date <= CURRENT_DATE THEN 'Off Roll'
      WHEN start_date > CURRENT_DATE THEN 'Pending'
      ELSE 'Unknown'
    END
  WHERE status != 
    CASE
      WHEN start_date <= CURRENT_DATE AND (end_date IS NULL OR end_date > CURRENT_DATE) THEN 'On Roll'
      WHEN end_date IS NOT NULL AND end_date <= CURRENT_DATE THEN 'Off Roll'
      WHEN start_date > CURRENT_DATE THEN 'Pending'
      ELSE 'Unknown'
    END;
END;
$$;


ALTER FUNCTION "public"."update_admission_status_daily"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_all_student_ages"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Assuming you have a column named 'age' in the student_admissions table
    -- If not, you'll need to add this column first
    UPDATE public.student_admissions
    SET age = DATE_PART('year', AGE(CURRENT_DATE, dob));
END;
$$;


ALTER FUNCTION "public"."update_all_student_ages"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_contacts_timestamp"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
   NEW.updated_at = CURRENT_TIMESTAMP;
   RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_contacts_timestamp"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_event_follow_up_interval"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.interval := NEW.interval_days * INTERVAL '1 day';
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_event_follow_up_interval"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_event_template_interval"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.interval := NEW.interval_days * INTERVAL '1 day';
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_event_template_interval"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_globals"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    v_current_date DATE;
    v_current_academic_year UUID;
    v_current_term UUID;
    v_current_week UUID;
    v_log_message TEXT;
BEGIN
    -- Set the current date
    v_current_date := CURRENT_DATE;

    -- Find the current week
    SELECT id, term_id INTO v_current_week, v_current_term
    FROM weeks
    WHERE v_current_date BETWEEN week_start AND week_end
    ORDER BY week_start DESC
    LIMIT 1;

    IF v_current_week IS NULL THEN
        v_log_message := 'No current week found for date ' || v_current_date;
        RAISE WARNING '%', v_log_message;
        INSERT INTO error_log (message) VALUES (v_log_message);
        RETURN;
    END IF;

    -- Find the current term and academic year
    SELECT t.id, t.academic_year_id 
    INTO v_current_term, v_current_academic_year
    FROM terms t
    WHERE t.id = v_current_term;

    IF v_current_term IS NULL OR v_current_academic_year IS NULL THEN
        v_log_message := 'No term or academic year found for week ' || v_current_week;
        RAISE WARNING '%', v_log_message;
        INSERT INTO error_log (message) VALUES (v_log_message);
        RETURN;
    END IF;

    -- Update or insert into globals table
    INSERT INTO globals (current_academic_year, current_term, current_week, global_date)
    VALUES (v_current_academic_year, v_current_term, v_current_week, v_current_date)
    ON CONFLICT (id)
    DO UPDATE SET
        current_academic_year = EXCLUDED.current_academic_year,
        current_term = EXCLUDED.current_term,
        current_week = EXCLUDED.current_week,
        global_date = EXCLUDED.global_date;

    v_log_message := 'Globals updated successfully for date ' || v_current_date;
    RAISE NOTICE '%', v_log_message;
END;
$$;


ALTER FUNCTION "public"."update_globals"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_group_memberships"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    member_id uuid;
BEGIN
    -- Set all existing records to inactive
    UPDATE student_groups SET status = 'inactive' WHERE group_id = NEW.id;
    UPDATE user_groups SET status = 'inactive' WHERE group_id = NEW.id;

    -- Handle student members
    IF NEW.student_members IS NOT NULL THEN
        FOR member_id IN SELECT jsonb_array_elements_text(NEW.student_members)::uuid
        LOOP
            INSERT INTO student_groups (group_id, student_id, service_id, status)
            VALUES (NEW.id, member_id, NEW.service_id, 'active')
            ON CONFLICT (group_id, student_id) 
            DO UPDATE SET status = 'active', created_at = CURRENT_TIMESTAMP;
        END LOOP;
    END IF;

    -- Handle staff members
    IF NEW.staff_members IS NOT NULL THEN
        FOR member_id IN SELECT jsonb_array_elements_text(NEW.staff_members)::uuid
        LOOP
            INSERT INTO user_groups (group_id, user_id, role, service_id, status)
            VALUES (NEW.id, member_id, NULL, NEW.service_id, 'active')
            ON CONFLICT (id) 
            DO UPDATE SET status = 'active', updated_at = CURRENT_TIMESTAMP;
        END LOOP;
    END IF;

    -- Handle teacher
    IF NEW.teacher IS NOT NULL THEN
        INSERT INTO user_groups (group_id, user_id, role, service_id, status)
        VALUES (NEW.id, NEW.teacher, 'Teacher', NEW.service_id, 'active')
        ON CONFLICT (id) 
        DO UPDATE SET role = 'Teacher', status = 'active', updated_at = CURRENT_TIMESTAMP;
    END IF;

    -- Handle CC
    IF NEW.cc IS NOT NULL THEN
        INSERT INTO user_groups (group_id, user_id, role, service_id, status)
        VALUES (NEW.id, NEW.cc, 'CC', NEW.service_id, 'active')
        ON CONFLICT (id) 
        DO UPDATE SET role = 'CC', status = 'active', updated_at = CURRENT_TIMESTAMP;
    END IF;

    -- Handle RSL
    IF NEW.rsl IS NOT NULL THEN
        INSERT INTO user_groups (group_id, user_id, role, service_id, status)
        VALUES (NEW.id, NEW.rsl, 'RSL', NEW.service_id, 'active')
        ON CONFLICT (id) 
        DO UPDATE SET role = 'RSL', status = 'active', updated_at = CURRENT_TIMESTAMP;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_group_memberships"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_lookup_on_change"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Update lookup only if record_type changed
    IF NEW.record_type <> OLD.record_type THEN
        NEW.lookup := NEW.record_type || '-' || NEW.serial_no::text;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_lookup_on_change"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_modified_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_modified_column"() OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."x_import_admissions" (
    "Service" "text",
    "Student" "text",
    "StartDate" "date",
    "EndDate" "date",
    "LocalAuthority" "text",
    "DOB" "date",
    "Age" bigint,
    "Status" "text",
    "Nationality" "text",
    "Ethnicity" "text",
    "Religion" "text",
    "Diagnosis" "text",
    "CurrentHomeAddress" "text",
    "CurrentHomeAddress : Street 1" "text",
    "CurrentHomeAddress : Street 2" "text",
    "CurrentHomeAddress : City" "text",
    "CurrentHomeAddress : State" "text",
    "CurrentHomeAddress : Zip" "text",
    "CurrentHomeAddress : Country" "text",
    "CurrentHomeAddress : Latitude" "text",
    "CurrentHomeAddress : Longitude" "text",
    "PreviousHomeAddress" "text",
    "PreviousHomeAddress : Street 1" "text",
    "PreviousHomeAddress : Street 2" "text",
    "PreviousHomeAddress : City" "text",
    "PreviousHomeAddress : State" "text",
    "PreviousHomeAddress : Zip" "text",
    "PreviousHomeAddress : Country" "text",
    "PreviousHomeAddress : Latitude" "text",
    "PreviousHomeAddress : Longitude" "text",
    "LastSchoolAttended" "text",
    "DateCreated" "text",
    "PreviousPlacementAdditionalInfo" "text",
    "ULN/UCI" "text",
    "Destination" "text",
    "bUpdate" bigint,
    "AutoIncrement" bigint,
    "EntryID" bigint,
    "bLAC" "text",
    "Sex" "text",
    "LastUpdated" "text",
    "SGSent" "text",
    "supabase_id" "text",
    "student_id" "text",
    "service_id" "text"
);


ALTER TABLE "public"."x_import_admissions" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_student_admission"("import_record" "public"."x_import_admissions") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    v_service_id uuid;
    v_student_id uuid;
    v_local_authority_id uuid;
    v_last_school_id uuid;
    v_admission_id uuid;
BEGIN
    -- Get service_id and student_id
    v_service_id := import_record.service_id::uuid;
    v_student_id := import_record.student_id::uuid;

    -- Find existing admission record
    SELECT id INTO v_admission_id
    FROM student_admissions
    WHERE student_id = v_student_id AND service_id = v_service_id;

    -- If no matching record found, skip
    IF v_admission_id IS NULL THEN
        RAISE NOTICE 'No matching admission record found for student % in service %. Skipping.', v_student_id, v_service_id;
        RETURN;
    END IF;

    -- Get or create local authority
    SELECT id INTO v_local_authority_id
    FROM organisations
    WHERE organisation_name = import_record."LocalAuthority";

    IF v_local_authority_id IS NULL AND import_record."LocalAuthority" IS NOT NULL THEN
        INSERT INTO organisations (organisation_name)
        VALUES (import_record."LocalAuthority")
        RETURNING id INTO v_local_authority_id;
    END IF;

    -- Get or create last school attended
    SELECT id INTO v_last_school_id
    FROM organisations
    WHERE organisation_name = import_record."LastSchoolAttended";

    IF v_last_school_id IS NULL AND import_record."LastSchoolAttended" IS NOT NULL THEN
        INSERT INTO organisations (organisation_name)
        VALUES (import_record."LastSchoolAttended")
        RETURNING id INTO v_last_school_id;
    END IF;

    -- Update student_admissions record
    UPDATE student_admissions
    SET
        start_date = COALESCE(import_record."StartDate", start_date),
        end_date = COALESCE(import_record."EndDate", end_date),
        local_authority_id = v_local_authority_id,
        dob = COALESCE(import_record."DOB", dob),
        nationality = import_record."Nationality",
        ethnicity = import_record."Ethnicity",
        religion = import_record."Religion",
        current_home_address1 = import_record."CurrentHomeAddress : Street 1",
        current_home_address2 = import_record."CurrentHomeAddress : Street 2",
        current_home_town = import_record."CurrentHomeAddress : City",
        current_home_county = import_record."CurrentHomeAddress : State",
        current_home_postcode = import_record."CurrentHomeAddress : Zip",
        previous_home_address1 = import_record."PreviousHomeAddress : Street 1",
        previous_home_address2 = import_record."PreviousHomeAddress : Street 2",
        previous_home_town = import_record."PreviousHomeAddress : City",
        previous_home_county = import_record."PreviousHomeAddress : State",
        previous_home_postcode = import_record."PreviousHomeAddress : Zip",
        last_school_attended_id = v_last_school_id,
        previous_placement_additional_info = import_record."PreviousPlacementAdditionalInfo",
        uln_uci = import_record."ULN/UCI",
        destination = import_record."Destination",
        sex = import_record."Sex",
        sg_data_sent = (import_record."SGSent" = 'Yes'),
        updated_at = CURRENT_TIMESTAMP
    WHERE id = v_admission_id;

END;
$$;


ALTER FUNCTION "public"."update_student_admission"("import_record" "public"."x_import_admissions") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_student_contacts_timestamp"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
   NEW.updated_at = CURRENT_TIMESTAMP;
   RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_student_contacts_timestamp"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_student_needsoutcomes_audit_fields"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    NEW.updated_date = now();
    NEW.updated_by = auth.uid();
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_student_needsoutcomes_audit_fields"() OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."accounts" (
    "id" "uuid" NOT NULL,
    "name" "text",
    "name_first" "text",
    "name_last" "text",
    "email" "text",
    "user_status" "text",
    "created_at" timestamp with time zone
);


ALTER TABLE "public"."accounts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."actions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "student_id" "uuid",
    "service_id" "uuid",
    "assigned_to" "uuid",
    "student_record_id" "uuid",
    "organisation_id" "uuid",
    "student_event_id" "uuid",
    "student_relational_id" "uuid",
    "type" "text",
    "details" "text",
    "due_date" "date",
    "status" "text" DEFAULT 'Open'::"text",
    "completed_by" "uuid",
    "completed_date" "date",
    "created_by" "uuid",
    "date" "date",
    "time" time without time zone,
    "completion_notes" "text"
);


ALTER TABLE "public"."actions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."audit_log" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "table_name" "text" NOT NULL,
    "record_id" "uuid" NOT NULL,
    "field_name" "text" NOT NULL,
    "old_value" "text",
    "new_value" "text",
    "action" "text" NOT NULL,
    "action_timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "action_by" "uuid" NOT NULL,
    "service_id" "uuid",
    "student_id" "uuid"
);


ALTER TABLE "public"."audit_log" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."confidential_access" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_record_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "granted_by" "uuid" NOT NULL,
    "granted_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "revoked_at" timestamp with time zone,
    "revoked_by" "uuid",
    "reason" "text"
);


ALTER TABLE "public"."confidential_access" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."contacts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "first_name" "text" NOT NULL,
    "organisation_id" "uuid",
    "job_title" "text",
    "department" "text",
    "email" "text",
    "landline" "text",
    "mobile" "text",
    "address_line1" "text",
    "address_line2" "text",
    "address_line3" "text",
    "address_town" "text",
    "address_postcode" "text",
    "address_county" "text",
    "comments" "text",
    "status" "text" DEFAULT 'active'::"text",
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "service_id" "uuid",
    "last_name" "text" NOT NULL
);


ALTER TABLE "public"."contacts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."error_log" (
    "id" integer NOT NULL,
    "message" "text",
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE "public"."error_log" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."error_log_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."error_log_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."error_log_id_seq" OWNED BY "public"."error_log"."id";



CREATE TABLE IF NOT EXISTS "public"."event_follow_ups" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "template_id" "uuid" NOT NULL,
    "follow_up_order" integer NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "interval_days" integer,
    "interval" interval
);


ALTER TABLE "public"."event_follow_ups" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."event_templates" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "category_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "has_follow_ups" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "duration" integer,
    "interval_days" integer,
    "interval" interval
);


ALTER TABLE "public"."event_templates" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."globals" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "current_academic_year" "uuid" NOT NULL,
    "current_term" "uuid" NOT NULL,
    "current_week" "uuid" NOT NULL,
    "global_date" "date"
);


ALTER TABLE "public"."globals" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."groups" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "service_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "status" "text" DEFAULT 'active'::"text",
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "type" "text",
    "student_members" "jsonb",
    "staff_members" "jsonb",
    "teacher" "uuid",
    "cc" "uuid",
    "rsl" "uuid"
);


ALTER TABLE "public"."groups" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."links" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "type" "text"[],
    "description" "text" NOT NULL,
    "url" "text",
    "service_id" "uuid",
    "student_id" "uuid",
    "record_id" "uuid",
    "confidential" boolean DEFAULT false,
    "name" "text"
);


ALTER TABLE "public"."links" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."lu_academic_years" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text",
    "status" "text" DEFAULT 'active'::"text",
    "start_date" "date",
    "end_date" "date",
    "sorting" bigint
);


ALTER TABLE "public"."lu_academic_years" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."lu_applications" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "name" "text" NOT NULL,
    "description" "text"
);


ALTER TABLE "public"."lu_applications" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."lu_categories" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name_short_code" "text" NOT NULL,
    "description" "text",
    "status" "text" DEFAULT 'active'::"text" NOT NULL,
    "type" "text" NOT NULL,
    "meaning" "text",
    "authorised" boolean,
    "unauthorised" boolean,
    "present" boolean,
    "admin" boolean,
    "c_authorised" boolean,
    "date_created" "date",
    "codeset" "text",
    "sorting" bigint,
    "record_type" "text",
    "record_level" "text"
);


ALTER TABLE "public"."lu_categories" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."lu_counties" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text",
    "country" "text"
);


ALTER TABLE "public"."lu_counties" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."lu_diagnosis" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text"
);


ALTER TABLE "public"."lu_diagnosis" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."lu_group_types" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text"
);


ALTER TABLE "public"."lu_group_types" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."lu_record_categories" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" character varying(255) NOT NULL,
    "type" character varying(50),
    "status" character varying(20) DEFAULT 'active'::character varying,
    "record_type" "text",
    "one_form_statements" boolean DEFAULT false,
    "record_level" "text"
);


ALTER TABLE "public"."lu_record_categories" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."lu_record_subcategories" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" character varying(255) NOT NULL,
    "record_category_id" "uuid",
    "status" character varying(20) DEFAULT 'active'::character varying,
    "type" character varying(255),
    "subcategory_type" character varying(50),
    "record_level" "text",
    "record_type" "text"
);


ALTER TABLE "public"."lu_record_subcategories" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."lu_roles" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "name" "text" NOT NULL,
    "description" "text"
);


ALTER TABLE "public"."lu_roles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."lu_terms" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text"
);


ALTER TABLE "public"."lu_terms" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."notification_distribution" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "recipient_id" "uuid",
    "status" "text",
    "notification_header_id" "uuid",
    "last_updated" timestamp without time zone DEFAULT "now"()
);


ALTER TABLE "public"."notification_distribution" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."notification_header" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "student_record_id" "uuid" DEFAULT "gen_random_uuid"(),
    "body" "text",
    "sender-id" "uuid",
    "date_sent" "date",
    "subject" "text"
);


ALTER TABLE "public"."notification_header" OWNER TO "postgres";


COMMENT ON TABLE "public"."notification_header" IS 'holds information for notifications';



CREATE TABLE IF NOT EXISTS "public"."organisations" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "organisation_name" "text" NOT NULL,
    "is_local_authority" boolean DEFAULT false NOT NULL,
    "general_email_address" "text",
    "phone" "text",
    "address_line1" "text",
    "address_line2" "text",
    "address_line3" "text",
    "address_town" "text",
    "address_county" "text",
    "address_postcode" "text",
    "org_type" "text"
);


ALTER TABLE "public"."organisations" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."records_auto_increment_seq"
    START WITH 80000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."records_auto_increment_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."reports" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text",
    "description" "text",
    "stimulsoft_url" "text",
    "criteria" "jsonb",
    "system_area" "text",
    "is_visible_on_reports_page" boolean DEFAULT false,
    "sequence" numeric,
    "is_slt_only" boolean DEFAULT false,
    "is_in_test" boolean DEFAULT true,
    "service_id" "uuid",
    "report_created_by_initials" "text"
);


ALTER TABLE "public"."reports" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."services" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "status" "text",
    "initials" "text",
    "logo_url" "text",
    "domain" "text",
    "sg_email" "text",
    "regional_email" "text"
);


ALTER TABLE "public"."services" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_admissions" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "service_id" "uuid" NOT NULL,
    "student_id" "uuid" NOT NULL,
    "start_date" "date",
    "end_date" "date",
    "local_authority_id" "uuid",
    "dob" "date",
    "status" "text",
    "nationality" "text",
    "ethnicity" "text",
    "religion" "text",
    "current_home_address1" "text",
    "current_home_address2" "text",
    "current_home_address3" "text",
    "current_home_postcode" "text",
    "current_home_town" "text",
    "current_home_county" "text",
    "previous_home_address1" "text",
    "previous_home_address2" "text",
    "previous_home_address3" "text",
    "previous_home_postcode" "text",
    "previous_home_town" "text",
    "previous_home_county" "text",
    "last_school_attended_id" "uuid",
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "previous_placement_additional_info" "text",
    "uln_uci" "text",
    "destination" "text",
    "sex" "text",
    "gender_identity" "text",
    "sg_data_sent" boolean,
    "created_by" "uuid",
    "updated_by" "uuid",
    "updated_at" timestamp with time zone,
    "is_current" boolean DEFAULT true NOT NULL
);


ALTER TABLE "public"."student_admissions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_attendance" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_id" "uuid",
    "service_id" "uuid",
    "term_id" "uuid",
    "week_id" "uuid",
    "date" "date",
    "session" character(2) NOT NULL,
    "attendance_code_id" "uuid",
    "comments" "text",
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "created_by" "uuid",
    "updated_at" timestamp with time zone,
    "updated_by" "uuid",
    CONSTRAINT "student_attendance_session_check" CHECK (("session" = ANY (ARRAY['AM'::"bpchar", 'PM'::"bpchar"])))
);


ALTER TABLE "public"."student_attendance" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_contacts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_id" "uuid",
    "service_id" "uuid",
    "contact_id" "uuid",
    "relationship" "text",
    "emergency_contact" boolean DEFAULT false,
    "lives_with_this_contact" boolean DEFAULT false,
    "parental_responsibility" boolean DEFAULT false,
    "created_by" "uuid",
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE "public"."student_contacts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_events" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "service_id" "uuid" NOT NULL,
    "template_id" "uuid",
    "parent_event_id" "uuid",
    "follow_up_order" integer,
    "start_date" "date" NOT NULL,
    "end_date" "date",
    "status" "text" DEFAULT 'active'::"text",
    "created_by" "uuid",
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "title" "text",
    "description" "text",
    "all_day" boolean DEFAULT false,
    "start_time" time without time zone,
    "end_time" time without time zone,
    "updated_by" "uuid",
    "url" "text",
    CONSTRAINT "check_follow_up_order" CHECK (((("parent_event_id" IS NULL) AND ("follow_up_order" IS NULL)) OR (("parent_event_id" IS NOT NULL) AND ("follow_up_order" IS NOT NULL))))
);


ALTER TABLE "public"."student_events" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_groups" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "group_id" "uuid" NOT NULL,
    "student_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "status" "text" DEFAULT 'active'::"text",
    "service_id" "uuid" NOT NULL
);


ALTER TABLE "public"."student_groups" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_needsoutcomes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "service_id" "uuid" NOT NULL,
    "student_id" "uuid" NOT NULL,
    "ehcp_category_id" "uuid",
    "description" "text",
    "source" "text",
    "status" "text" DEFAULT 'active'::"text",
    "type" "text",
    "when" "text",
    "created_date" timestamp with time zone DEFAULT "now"(),
    "created_by" "uuid",
    "updated_date" timestamp with time zone,
    "updated_by" "uuid"
);


ALTER TABLE "public"."student_needsoutcomes" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."student_records_serial_seq"
    START WITH 70000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."student_records_serial_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_records" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "lookup" character varying(255),
    "service_id" "uuid",
    "student_id" "uuid",
    "record_type" character varying(255),
    "record_category_id" "uuid",
    "record_subcategory_id" "uuid",
    "academic_year_id" "uuid",
    "term_id" "uuid",
    "date" "date",
    "details" "text",
    "status" character varying(50) DEFAULT 'New'::character varying,
    "entry_id" character varying(255),
    "auto_increment" integer NOT NULL,
    "is_confidential" boolean DEFAULT false,
    "other_students" "jsonb",
    "other_staff" "jsonb",
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "created_by" "uuid" DEFAULT "auth"."uid"(),
    "updated_by" "uuid",
    "record_date" "date",
    "risk_level" "text",
    "risk_score" integer,
    "review_date" "date",
    "is_child_on_child" boolean DEFAULT false,
    "is_esafety" boolean DEFAULT false,
    "is_bullying" boolean DEFAULT false,
    "legacy_data" "jsonb",
    "incident_data" "jsonb",
    "safeguarding_data" "jsonb",
    "actions_required" "jsonb",
    "pi_data" "jsonb",
    "review_completed" boolean,
    "staff_feedback_provided" boolean,
    "evidence_location" "text",
    "serial_no" bigint DEFAULT "nextval"('"public"."student_records_serial_seq"'::"regclass"),
    "contact_id" "uuid",
    "needs_data" "jsonb",
    "new_statement" "text",
    "students_injured" "jsonb",
    "staff_injured" "jsonb",
    "star_recording" "jsonb",
    "is_students_injured" boolean DEFAULT false,
    "is_staff_injured" boolean DEFAULT false,
    "status_changed_by" "uuid",
    "is_pi" boolean DEFAULT false,
    "notifications_data" "jsonb",
    "other_external" "jsonb"
);


ALTER TABLE "public"."student_records" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."student_records_auto_increment_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."student_records_auto_increment_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."student_records_auto_increment_seq" OWNED BY "public"."student_records"."auto_increment";



CREATE TABLE IF NOT EXISTS "public"."student_records_interventions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "student_record_id" "uuid" NOT NULL,
    "hold" "text",
    "hold_other" "text",
    "duration" character varying,
    "rationale" "text",
    "staff_involved" "jsonb"[],
    "de-escalation" "text",
    "status" "text" DEFAULT 'active'::"text"
);


ALTER TABLE "public"."student_records_interventions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_records_needs" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_record_id" "uuid" NOT NULL,
    "student_needoutcome_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."student_records_needs" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_records_reviews" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "created_by" "uuid",
    "type" "text",
    "reflection" "text",
    "doc_changes" "text"[],
    "student_record_id" "uuid" NOT NULL,
    "date" "date" NOT NULL
);


ALTER TABLE "public"."student_records_reviews" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_records_staff" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_record_id" "uuid" NOT NULL,
    "staff_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."student_records_staff" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_records_students" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "student_record_id" "uuid" NOT NULL,
    "student_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."student_records_students" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_relational" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "student_id" "uuid" NOT NULL,
    "service_id" "uuid" NOT NULL,
    "strengths_interests" "text",
    "communication" "text",
    "distress_triggers" "text",
    "safe_what" "text",
    "safe_who" "text",
    "peer_relationships" "text",
    "adult_relationships" "text",
    "distress_presentation" "text",
    "happy_presentation" "text",
    "how_to_engage" "text",
    "support_learning" "text",
    "access_arrangements" "text",
    "context" "text",
    "health_needs" "text",
    "known_needs" "text",
    "created_by" "uuid",
    "updated_by" "uuid",
    "diagnosis" "text"[]
);


ALTER TABLE "public"."student_relational" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."student_tags" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "student_id" "uuid" NOT NULL,
    "service_id" "uuid" NOT NULL,
    "short_tag" "text" NOT NULL,
    "status" "text" DEFAULT 'active'::"text" NOT NULL,
    "type" "text" NOT NULL,
    "created_by" "uuid",
    "updated_by" "uuid"
);


ALTER TABLE "public"."student_tags" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."students" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "name" "text" NOT NULL,
    "service_id" "uuid" NOT NULL,
    "initials" "text" NOT NULL,
    "first_name" "text" NOT NULL,
    "middle_name" "text",
    "surname" "text" NOT NULL,
    "preferred_name" "text",
    "color_code" "text",
    "updated_by" "uuid",
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."students" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."terms" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "academic_year_id" "uuid",
    "lu_term_id" "uuid",
    "status" character varying(50),
    "name" character varying(100),
    "start_date" "date",
    "end_date" "date",
    "sorting" bigint,
    "created_at" timestamp with time zone
);


ALTER TABLE "public"."terms" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_applications" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid",
    "application_id" "uuid"
);


ALTER TABLE "public"."user_applications" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_groups" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "group_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "role" "text",
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "status" "text" DEFAULT 'active'::"text" NOT NULL,
    "service_id" "uuid" NOT NULL
);


ALTER TABLE "public"."user_groups" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_roles" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_application_id" "uuid",
    "roleId" "uuid",
    "userId" "uuid" NOT NULL,
    "service_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."user_roles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_services" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid",
    "service_id" "uuid",
    "status" "text" DEFAULT 'active'::"text",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."user_services" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_actions" WITH ("security_invoker"='on') AS
 SELECT "a"."id",
    "a"."created_at",
    "a"."student_id",
    "s"."name" AS "student_name",
    "a"."service_id",
    "srv"."name" AS "service_name",
    "a"."assigned_to",
    COALESCE(("au"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "assigned_to_name",
    "a"."student_record_id",
    "sr"."lookup" AS "student_record_lookup",
    "a"."organisation_id",
    "a"."student_event_id",
    "a"."student_relational_id",
    "a"."type",
    "a"."details",
    "a"."due_date",
    "a"."date",
    "a"."time",
    "a"."status",
    "a"."completed_by",
    "a"."completion_notes",
    COALESCE(("cu"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "completed_by_name",
    "a"."completed_date",
    "a"."created_by",
    COALESCE(("cru"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "created_by_name"
   FROM (((((("public"."actions" "a"
     LEFT JOIN "public"."students" "s" ON (("a"."student_id" = "s"."id")))
     LEFT JOIN "public"."services" "srv" ON (("a"."service_id" = "srv"."id")))
     LEFT JOIN "auth"."users" "au" ON (("a"."assigned_to" = "au"."id")))
     LEFT JOIN "public"."student_records" "sr" ON (("a"."student_record_id" = "sr"."id")))
     LEFT JOIN "auth"."users" "cu" ON (("a"."completed_by" = "cu"."id")))
     LEFT JOIN "auth"."users" "cru" ON (("a"."created_by" = "cru"."id")));


ALTER TABLE "public"."view_actions" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_attendance_codes" WITH ("security_invoker"='on') AS
 SELECT "lu_categories"."id",
    "lu_categories"."created_at",
    "lu_categories"."name_short_code",
    "lu_categories"."description",
    "lu_categories"."status",
    "lu_categories"."type",
    "lu_categories"."meaning",
    "lu_categories"."authorised",
    "lu_categories"."unauthorised",
    "lu_categories"."present",
    "lu_categories"."admin",
    "lu_categories"."c_authorised",
    "lu_categories"."date_created",
    "lu_categories"."codeset",
    "lu_categories"."sorting",
    COALESCE(TRIM(BOTH FROM "concat"("lu_categories"."name_short_code", ' - ', "lu_categories"."description")), "lu_categories"."name_short_code") AS "full_code_description"
   FROM "public"."lu_categories"
  WHERE ("lu_categories"."type" = 'Attendance'::"text")
  ORDER BY "lu_categories"."sorting";


ALTER TABLE "public"."view_attendance_codes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."weeks" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT ("now"() AT TIME ZONE 'utc'::"text"),
    "week_number" bigint NOT NULL,
    "term_id" "uuid",
    "week_start" "date",
    "week_end" "date",
    "week_name" "text",
    "kpi_week_start" "date",
    "kpi_week_end" "date"
);


ALTER TABLE "public"."weeks" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_attendance_kpis" WITH ("security_invoker"='on') AS
 SELECT "sa"."service_id",
    "s"."name" AS "service_name",
    "sa"."date",
    "count"(*) AS "total_attendance_count",
    "count"(*) FILTER (WHERE ("lc"."present" = true)) AS "present_count",
    "count"(*) FILTER (WHERE ("lc"."authorised" = true)) AS "authorised_count",
    "count"(*) FILTER (WHERE ("lc"."unauthorised" = true)) AS "unauthorised_count",
    "count"(*) FILTER (WHERE ("lc"."c_authorised" = true)) AS "c_authorised_count",
    "count"(*) FILTER (WHERE ("lc"."admin" = true)) AS "admin_count",
    "count"(*) FILTER (WHERE ("sa"."attendance_code_id" IS NULL)) AS "uncoded_count",
    "count"(*) FILTER (WHERE ("sa"."attendance_code_id" = ANY (ARRAY['70777694-035d-4b20-a693-77dd9d9b46ed'::"uuid", '70777694-035d-4b20-a693-77dd9d9b46ed'::"uuid"]))) AS "e_code_count",
    "round"(((100.0 * ("count"(*) FILTER (WHERE ("lc"."present" = true)))::numeric) / (NULLIF("count"(*), 0))::numeric), 2) AS "present_percentage",
    "round"(((100.0 * ("count"(*) FILTER (WHERE ("lc"."authorised" = true)))::numeric) / (NULLIF("count"(*), 0))::numeric), 2) AS "authorised_percentage",
    "round"(((100.0 * ("count"(*) FILTER (WHERE ("lc"."unauthorised" = true)))::numeric) / (NULLIF("count"(*), 0))::numeric), 2) AS "unauthorised_percentage",
    "round"(((100.0 * ("count"(*) FILTER (WHERE ("lc"."c_authorised" = true)))::numeric) / (NULLIF("count"(*), 0))::numeric), 2) AS "c_authorised_percentage",
    "round"(((100.0 * ("count"(*) FILTER (WHERE ("lc"."admin" = true)))::numeric) / (NULLIF("count"(*), 0))::numeric), 2) AS "admin_percentage",
    "round"(((100.0 * ("count"(*) FILTER (WHERE ("sa"."attendance_code_id" IS NULL)))::numeric) / (NULLIF("count"(*), 0))::numeric), 2) AS "uncoded_percentage",
    "round"(((100.0 * ("count"(*) FILTER (WHERE ("sa"."attendance_code_id" = ANY (ARRAY['70777694-035d-4b20-a693-77dd9d9b46ed'::"uuid", '70777694-035d-4b20-a693-77dd9d9b46ed'::"uuid"]))))::numeric) / (NULLIF("count"(*), 0))::numeric), 2) AS "e_code_percentage",
    ("count"(*) FILTER (WHERE ("lc"."authorised" = true)) - "count"(*) FILTER (WHERE ("sa"."attendance_code_id" = ANY (ARRAY['70777694-035d-4b20-a693-77dd9d9b46ed'::"uuid", '70777694-035d-4b20-a693-77dd9d9b46ed'::"uuid"])))) AS "adjusted_authorised_count"
   FROM ((("public"."student_attendance" "sa"
     JOIN "public"."services" "s" ON (("sa"."service_id" = "s"."id")))
     JOIN "public"."weeks" "w" ON (("sa"."week_id" = "w"."id")))
     LEFT JOIN "public"."lu_categories" "lc" ON (("sa"."attendance_code_id" = "lc"."id")))
  GROUP BY "sa"."service_id", "s"."name", "sa"."date";


ALTER TABLE "public"."view_attendance_kpis" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_comprehensive_attendance_statistics" WITH ("security_invoker"='on') AS
 WITH "date_series" AS (
         SELECT "generate_series"(("date_trunc"('week'::"text", (CURRENT_DATE)::timestamp with time zone) - '35 days'::interval), "date_trunc"('week'::"text", (CURRENT_DATE)::timestamp with time zone), '7 days'::interval) AS "week_start"
        ), "weekly_attendance" AS (
         SELECT "sa"."service_id",
            "date_trunc"('week'::"text", ("sa"."date")::timestamp with time zone) AS "week_start",
            "count"(*) AS "total_records",
            "count"(
                CASE
                    WHEN "lc"."present" THEN 1
                    ELSE NULL::integer
                END) AS "present_count"
           FROM ("public"."student_attendance" "sa"
             LEFT JOIN "public"."lu_categories" "lc" ON (("sa"."attendance_code_id" = "lc"."id")))
          WHERE ("sa"."date" >= (CURRENT_DATE - '42 days'::interval))
          GROUP BY "sa"."service_id", ("date_trunc"('week'::"text", ("sa"."date")::timestamp with time zone))
        ), "on_roll_counts" AS (
         SELECT "sa"."service_id",
            "count"(*) AS "on_roll_count"
           FROM "public"."student_admissions" "sa"
          WHERE ("sa"."status" = 'On Roll'::"text")
          GROUP BY "sa"."service_id"
        ), "today_attendance" AS (
         SELECT "sa"."service_id",
            "count"(*) AS "total_records",
            "count"(
                CASE
                    WHEN "lc"."present" THEN 1
                    ELSE NULL::integer
                END) AS "present_count"
           FROM ("public"."student_attendance" "sa"
             LEFT JOIN "public"."lu_categories" "lc" ON (("sa"."attendance_code_id" = "lc"."id")))
          WHERE ("sa"."date" = CURRENT_DATE)
          GROUP BY "sa"."service_id"
        ), "year_to_date_attendance" AS (
         SELECT "sa"."service_id",
            "count"(*) AS "total_records",
            "count"(
                CASE
                    WHEN "lc"."present" THEN 1
                    ELSE NULL::integer
                END) AS "present_count"
           FROM ("public"."student_attendance" "sa"
             LEFT JOIN "public"."lu_categories" "lc" ON (("sa"."attendance_code_id" = "lc"."id")))
          WHERE ("sa"."date" >= "date_trunc"('year'::"text", (CURRENT_DATE)::timestamp with time zone))
          GROUP BY "sa"."service_id"
        ), "weekly_data" AS (
         SELECT "s_1"."id" AS "service_id",
            "ds"."week_start",
            COALESCE(
                CASE
                    WHEN ("wa"."total_records" > 0) THEN "round"(((("wa"."present_count")::numeric / ("wa"."total_records")::numeric) * (100)::numeric), 1)
                    ELSE NULL::numeric
                END, (0)::numeric) AS "attendance_percentage"
           FROM (("public"."services" "s_1"
             CROSS JOIN "date_series" "ds")
             LEFT JOIN "weekly_attendance" "wa" ON ((("s_1"."id" = "wa"."service_id") AND ("ds"."week_start" = "wa"."week_start"))))
          ORDER BY "s_1"."id", "ds"."week_start"
        )
 SELECT "s"."id" AS "service_id",
    "s"."name" AS "service_name",
    "orc"."on_roll_count" AS "current_enrollment",
    COALESCE("ta"."present_count", (0)::bigint) AS "today_present_count",
        CASE
            WHEN ("ta"."total_records" > 0) THEN "round"((((COALESCE("ta"."present_count", (0)::bigint))::numeric / ("ta"."total_records")::numeric) * (100)::numeric), 1)
            ELSE (0)::numeric
        END AS "today_attendance_percentage",
        CASE
            WHEN ("yta"."total_records" > 0) THEN "round"(((("yta"."present_count")::numeric / ("yta"."total_records")::numeric) * (100)::numeric), 1)
            ELSE (0)::numeric
        END AS "year_to_date_attendance_percentage",
    "json_build_array"("json_build_object"('label', 'Weekly Attendance', 'backgroundColor', 'rgb(75, 192, 192)', 'data', ( SELECT "json_agg"("wd"."attendance_percentage" ORDER BY "wd"."week_start") AS "json_agg"
           FROM "weekly_data" "wd"
          WHERE ("wd"."service_id" = "s"."id")))) AS "weekly_chart_data",
    ( SELECT "json_agg"("to_char"("date_series"."week_start", 'DD/MM'::"text") ORDER BY "date_series"."week_start") AS "json_agg"
           FROM "date_series") AS "weekly_chart_labels",
    "json_build_array"("json_build_object"('label', 'Attendance Comparison', 'backgroundColor', "json_build_array"('rgb(75, 192, 192)', 'rgb(255, 99, 132)'), 'data', "json_build_array"(
        CASE
            WHEN ("ta"."total_records" > 0) THEN "round"((((COALESCE("ta"."present_count", (0)::bigint))::numeric / ("ta"."total_records")::numeric) * (100)::numeric), 1)
            ELSE (0)::numeric
        END,
        CASE
            WHEN ("yta"."total_records" > 0) THEN "round"(((("yta"."present_count")::numeric / ("yta"."total_records")::numeric) * (100)::numeric), 1)
            ELSE (0)::numeric
        END))) AS "comparison_chart_data",
    "json_build_array"('Today', 'Overall') AS "comparison_chart_labels"
   FROM ((("public"."services" "s"
     LEFT JOIN "on_roll_counts" "orc" ON (("s"."id" = "orc"."service_id")))
     LEFT JOIN "today_attendance" "ta" ON (("s"."id" = "ta"."service_id")))
     LEFT JOIN "year_to_date_attendance" "yta" ON (("s"."id" = "yta"."service_id")))
  GROUP BY "s"."id", "s"."name", "orc"."on_roll_count", "ta"."present_count", "ta"."total_records", "yta"."present_count", "yta"."total_records"
  ORDER BY "s"."name";


ALTER TABLE "public"."view_comprehensive_attendance_statistics" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_contacts_info" WITH ("security_invoker"='on') AS
 SELECT "c"."id",
    "c"."id" AS "contact_id",
    TRIM(BOTH FROM "concat_ws"(' '::"text", COALESCE("c"."first_name", ''::"text"), COALESCE("c"."last_name", ''::"text"))) AS "full_name",
    TRIM(BOTH FROM "concat_ws"(' '::"text", COALESCE("c"."first_name", ''::"text"), COALESCE("c"."last_name", ''::"text"))) AS "display_name",
    COALESCE("c"."landline", ''::"text") AS "landline",
    COALESCE("c"."mobile", ''::"text") AS "mobile",
    COALESCE("c"."email", ''::"text") AS "email",
    COALESCE("c"."job_title", ''::"text") AS "job_title",
    COALESCE("c"."department", ''::"text") AS "department",
    COALESCE("c"."comments", ''::"text") AS "comments",
    "c"."service_id",
    "c"."first_name",
    "c"."last_name",
    false AS "is_organisation",
    COALESCE("o"."is_local_authority", false) AS "is_local_authority",
    COALESCE("o"."organisation_name", ''::"text") AS "organisation_name",
    "c"."organisation_id",
    COALESCE("o"."org_type", ''::"text") AS "org_type",
    COALESCE(TRIM(BOTH FROM "concat_ws"(', '::"text", NULLIF(COALESCE("c"."address_line1", ''::"text"), ''::"text"), NULLIF(COALESCE("c"."address_line2", ''::"text"), ''::"text"), NULLIF(COALESCE("c"."address_line3", ''::"text"), ''::"text"), NULLIF(COALESCE("c"."address_town", ''::"text"), ''::"text"), NULLIF(COALESCE("c"."address_county", ''::"text"), ''::"text"), NULLIF(COALESCE("c"."address_postcode", ''::"text"), ''::"text"))), ''::"text") AS "full_address",
        CASE
            WHEN ((COALESCE("o"."organisation_name", ''::"text") <> ''::"text") AND (COALESCE("c"."job_title", ''::"text") <> ''::"text")) THEN "concat"(COALESCE("o"."organisation_name", ''::"text"), '|', COALESCE("c"."job_title", ''::"text"))
            WHEN (COALESCE("o"."organisation_name", ''::"text") <> ''::"text") THEN COALESCE("o"."organisation_name", ''::"text")
            WHEN (COALESCE("c"."job_title", ''::"text") <> ''::"text") THEN COALESCE("c"."job_title", ''::"text")
            ELSE ''::"text"
        END AS "org_and_job",
    ( SELECT "array_agg"((("sc"."relationship" || ' > '::"text") ||
                CASE
                    WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN ((COALESCE("s"."preferred_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
                    ELSE ((COALESCE("s"."first_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
                END)) AS "array_agg"
           FROM ("public"."student_contacts" "sc"
             JOIN "public"."students" "s" ON (("sc"."student_id" = "s"."id")))
          WHERE ("sc"."contact_id" = "c"."id")) AS "student_relationships"
   FROM ("public"."contacts" "c"
     LEFT JOIN "public"."organisations" "o" ON (("c"."organisation_id" = "o"."id")))
UNION ALL
 SELECT "o"."id",
    "o"."id" AS "contact_id",
    ''::"text" AS "full_name",
    COALESCE("o"."organisation_name", ''::"text") AS "display_name",
    COALESCE("o"."phone", ''::"text") AS "landline",
    ''::"text" AS "mobile",
    COALESCE("o"."general_email_address", ''::"text") AS "email",
    ''::"text" AS "job_title",
    ''::"text" AS "department",
    ''::"text" AS "comments",
    NULL::"uuid" AS "service_id",
    ''::"text" AS "first_name",
    ''::"text" AS "last_name",
    true AS "is_organisation",
    "o"."is_local_authority",
    COALESCE("o"."organisation_name", ''::"text") AS "organisation_name",
    "o"."id" AS "organisation_id",
    COALESCE("o"."org_type", ''::"text") AS "org_type",
    COALESCE(TRIM(BOTH FROM "concat_ws"(', '::"text", NULLIF(COALESCE("o"."address_line1", ''::"text"), ''::"text"), NULLIF(COALESCE("o"."address_line2", ''::"text"), ''::"text"), NULLIF(COALESCE("o"."address_line3", ''::"text"), ''::"text"), NULLIF(COALESCE("o"."address_town", ''::"text"), ''::"text"), NULLIF(COALESCE("o"."address_county", ''::"text"), ''::"text"), NULLIF(COALESCE("o"."address_postcode", ''::"text"), ''::"text"))), ''::"text") AS "full_address",
    COALESCE("o"."organisation_name", ''::"text") AS "org_and_job",
    NULL::"text"[] AS "student_relationships"
   FROM "public"."organisations" "o";


ALTER TABLE "public"."view_contacts_info" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_user_names" AS
 SELECT "u"."id",
    ("u"."raw_user_meta_data" ->> 'full_name'::"text") AS "full_name",
    COALESCE("array_agg"("json_build_object"('service_id', "s"."id", 'service_name', "s"."name")) FILTER (WHERE ("s"."id" IS NOT NULL)), '{}'::"json"[]) AS "services"
   FROM (("auth"."users" "u"
     LEFT JOIN "public"."user_services" "us" ON (("u"."id" = "us"."user_id")))
     LEFT JOIN "public"."services" "s" ON (("us"."service_id" = "s"."id")))
  GROUP BY "u"."id", "u"."raw_user_meta_data";


ALTER TABLE "public"."view_user_names" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_user_services_info" WITH ("security_invoker"='on') AS
 SELECT "us"."user_id",
    "us"."status",
    "un"."full_name" AS "user_full_name",
    "au"."email" AS "user_email",
    "us"."service_id",
    "s"."name" AS "service_name",
    "s"."initials" AS "service_initials",
    "s"."status" AS "service_status"
   FROM ((("public"."user_services" "us"
     JOIN "public"."services" "s" ON (("us"."service_id" = "s"."id")))
     LEFT JOIN "public"."view_user_names" "un" ON (("us"."user_id" = "un"."id")))
     LEFT JOIN "auth"."users" "au" ON (("us"."user_id" = "au"."id")));


ALTER TABLE "public"."view_user_services_info" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_distinct_users" WITH ("security_invoker"='on') AS
 SELECT "view_user_services_info"."user_id",
    "view_user_services_info"."status",
    "view_user_services_info"."user_full_name",
    "view_user_services_info"."user_email"
   FROM "public"."view_user_services_info"
  GROUP BY "view_user_services_info"."user_id", "view_user_services_info"."status", "view_user_services_info"."user_full_name", "view_user_services_info"."user_email";


ALTER TABLE "public"."view_distinct_users" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_event_follow_ups" WITH ("security_invoker"='on') AS
 SELECT "event_follow_ups"."id",
    "event_follow_ups"."template_id",
    "event_follow_ups"."follow_up_order",
    "event_follow_ups"."interval_days",
    "public"."format_interval_display"("event_follow_ups"."interval") AS "interval_display",
    "event_follow_ups"."name",
    "event_follow_ups"."description",
    "event_follow_ups"."created_at",
    "event_follow_ups"."updated_at"
   FROM "public"."event_follow_ups";


ALTER TABLE "public"."view_event_follow_ups" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_event_templates" WITH ("security_invoker"='on') AS
 SELECT "event_templates"."id",
    "event_templates"."category_id",
    "event_templates"."name",
    "event_templates"."description",
    "event_templates"."has_follow_ups",
    "event_templates"."created_at",
    "event_templates"."updated_at",
    "event_templates"."duration",
    "event_templates"."interval_days",
    "public"."format_interval_display"("event_templates"."interval") AS "interval_display"
   FROM "public"."event_templates";


ALTER TABLE "public"."view_event_templates" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_globals_info" WITH ("security_invoker"='on') AS
 SELECT "g"."id",
    "g"."global_date",
    "g"."current_academic_year",
    "ay"."name" AS "academic_year_name",
    "g"."current_term",
    "t"."name" AS "term_name",
    "g"."current_week",
    "w"."week_name",
    "w"."week_number"
   FROM ((("public"."globals" "g"
     LEFT JOIN "public"."lu_academic_years" "ay" ON (("g"."current_academic_year" = "ay"."id")))
     LEFT JOIN "public"."terms" "t" ON (("g"."current_term" = "t"."id")))
     LEFT JOIN "public"."weeks" "w" ON (("g"."current_week" = "w"."id")));


ALTER TABLE "public"."view_globals_info" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_group_info" WITH ("security_invoker"='on') AS
 SELECT "g"."id" AS "group_id",
    "g"."name" AS "group_name",
    "g"."description" AS "group_description",
    "g"."status" AS "group_status",
    "g"."type" AS "group_type",
    "g"."service_id",
    "s"."name" AS "service_name"
   FROM ("public"."groups" "g"
     JOIN "public"."services" "s" ON (("g"."service_id" = "s"."id")));


ALTER TABLE "public"."view_group_info" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_group_members_info" WITH ("security_invoker"='on') AS
 SELECT "g"."id" AS "group_id",
    "g"."name" AS "group_name",
    "g"."description" AS "group_description",
    "g"."status" AS "group_status",
    "g"."type" AS "group_type",
    "g"."service_id",
    "g"."teacher" AS "teacher_id",
    "g"."cc" AS "cc_id",
    "g"."rsl" AS "rsl_id",
    "s"."name" AS "service_name",
    "g"."student_members",
    "g"."staff_members",
    "t"."full_name" AS "teacher_name",
    "cc"."full_name" AS "cc_name",
    "rsl"."full_name" AS "rsl_name",
        CASE
            WHEN ("g"."student_members" IS NULL) THEN 'null'::"text"
            WHEN ("g"."student_members" = '{}'::"jsonb") THEN 'empty'::"text"
            ELSE 'populated'::"text"
        END AS "student_members_status",
        CASE
            WHEN ("g"."staff_members" IS NULL) THEN 'null'::"text"
            WHEN ("g"."staff_members" = '{}'::"jsonb") THEN 'empty'::"text"
            ELSE 'populated'::"text"
        END AS "staff_members_status"
   FROM (((("public"."groups" "g"
     JOIN "public"."services" "s" ON (("g"."service_id" = "s"."id")))
     LEFT JOIN "public"."view_user_names" "t" ON (("g"."teacher" = "t"."id")))
     LEFT JOIN "public"."view_user_names" "cc" ON (("g"."cc" = "cc"."id")))
     LEFT JOIN "public"."view_user_names" "rsl" ON (("g"."rsl" = "rsl"."id")));


ALTER TABLE "public"."view_group_members_info" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_high_risk_open_records" WITH ("security_invoker"='on') AS
 SELECT "sr"."id",
    "sr"."service_id",
    "sv"."name" AS "service_name",
    "sr"."student_id",
    "s"."name" AS "student_name",
    "sr"."record_type",
    "sr"."risk_level",
    "sr"."status",
    "sr"."date",
    "sr"."created_at",
    "sr"."updated_at"
   FROM (("public"."student_records" "sr"
     JOIN "public"."students" "s" ON (("sr"."student_id" = "s"."id")))
     JOIN "public"."services" "sv" ON (("sr"."service_id" = "sv"."id")))
  WHERE (("sr"."risk_level" = ANY (ARRAY['Level 4'::"text", 'Level 5'::"text"])) AND (("sr"."status")::"text" = ANY (ARRAY['Open'::"text", 'New'::"text"])) AND ((("sr"."record_type")::"text" <> 'Safeguarding'::"text") OR ((("sr"."record_type")::"text" = 'Safeguarding'::"text") AND ((EXISTS ( SELECT 1
           FROM ("public"."user_roles" "ur"
             JOIN "public"."lu_roles" "lr" ON (("ur"."roleId" = "lr"."id")))
          WHERE (("ur"."userId" = "auth"."uid"()) AND ("ur"."service_id" = "sr"."service_id") AND ("lr"."name" = 'SLT'::"text")))) OR (EXISTS ( SELECT 1
           FROM "public"."confidential_access" "ca"
          WHERE (("ca"."user_id" = "auth"."uid"()) AND ("ca"."student_record_id" = "sr"."id") AND ("ca"."revoked_at" IS NULL))))))));


ALTER TABLE "public"."view_high_risk_open_records" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_high_risk_records_grid" WITH ("security_invoker"='on') AS
 SELECT "original_grid_view"."service_id",
    "original_grid_view"."service_name",
    "original_grid_view"."date",
    "original_grid_view"."created_by",
    "original_grid_view"."student_name",
    "original_grid_view"."type",
    "original_grid_view"."timestamp",
    "original_grid_view"."combined_id",
    "original_grid_view"."details",
    "original_grid_view"."status",
    "original_grid_view"."completed_by",
    "original_grid_view"."student_id",
    "original_grid_view"."id",
    "original_grid_view"."review_count",
    "original_grid_view"."action_count",
    "original_grid_view"."academic_year_id",
    "original_grid_view"."academic_year_name",
    "original_grid_view"."term_id",
    "original_grid_view"."term_name",
    "original_grid_view"."risk_level",
    "original_grid_view"."is_pi"
   FROM ( SELECT "sr"."service_id",
            "s"."name" AS "service_name",
            "sr"."date",
            "sr"."created_by",
            "st"."name" AS "student_name",
            "sr"."record_type" AS "type",
            "to_char"("sr"."created_at", 'DD/MM/YYYY HH24:MI:SS'::"text") AS "timestamp",
            COALESCE("sr"."lookup",
                CASE
                    WHEN ("sr"."serial_no" IS NOT NULL) THEN (((("sr"."record_type")::"text" || '-'::"text") || ("sr"."serial_no")::"text"))::character varying
                    ELSE "sr"."entry_id"
                END) AS "combined_id",
            "sr"."details",
            "sr"."status",
            COALESCE(("u"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "completed_by",
            "sr"."student_id",
            "sr"."id",
            COALESCE("review_count"."count", (0)::bigint) AS "review_count",
            COALESCE("action_count"."count", (0)::bigint) AS "action_count",
            "sr"."is_confidential",
            "sr"."academic_year_id",
            "lay"."name" AS "academic_year_name",
            "sr"."term_id",
            "lt"."name" AS "term_name",
            "sr"."risk_level",
            "sr"."is_pi"
           FROM ((((((("public"."student_records" "sr"
             JOIN "public"."services" "s" ON (("sr"."service_id" = "s"."id")))
             JOIN "public"."students" "st" ON (("sr"."student_id" = "st"."id")))
             LEFT JOIN "auth"."users" "u" ON (("sr"."created_by" = "u"."id")))
             LEFT JOIN "public"."lu_academic_years" "lay" ON (("sr"."academic_year_id" = "lay"."id")))
             LEFT JOIN "public"."lu_terms" "lt" ON (("sr"."term_id" = "lt"."id")))
             LEFT JOIN ( SELECT "student_records_reviews"."student_record_id",
                    "count"(*) AS "count"
                   FROM "public"."student_records_reviews"
                  GROUP BY "student_records_reviews"."student_record_id") "review_count" ON (("sr"."id" = "review_count"."student_record_id")))
             LEFT JOIN ( SELECT "actions"."student_record_id",
                    "count"(*) AS "count"
                   FROM "public"."actions"
                  GROUP BY "actions"."student_record_id") "action_count" ON (("sr"."id" = "action_count"."student_record_id")))
          WHERE ((("sr"."risk_level" = ANY (ARRAY['Level 4'::"text", 'Level 5'::"text"])) OR ("sr"."is_pi" = true)) AND (("sr"."status")::"text" <> 'inactive'::"text"))
          ORDER BY "sr"."date" DESC, "sr"."created_at" DESC) "original_grid_view";


ALTER TABLE "public"."view_high_risk_records_grid" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_local_authority_info" WITH ("security_invoker"='on') AS
 SELECT "organisations"."id",
    "organisations"."organisation_name",
    COALESCE("organisations"."phone", ''::"text") AS "phone",
    COALESCE("organisations"."general_email_address", ''::"text") AS "email"
   FROM "public"."organisations"
  WHERE ("organisations"."is_local_authority" = true);


ALTER TABLE "public"."view_local_authority_info" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_one_form_categories" WITH ("security_invoker"='on') AS
 SELECT "lu_record_categories"."id",
    "lu_record_categories"."name",
    "lu_record_categories"."type",
    "lu_record_categories"."status",
    "lu_record_categories"."record_type",
    "lu_record_categories"."one_form_statements",
    "lu_record_categories"."record_level"
   FROM "public"."lu_record_categories"
  WHERE ((("lu_record_categories"."status")::"text" = 'active'::"text") AND ("lu_record_categories"."one_form_statements" = true));


ALTER TABLE "public"."view_one_form_categories" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_one_form_statements" WITH ("security_invoker"='true') AS
 SELECT "lu_categories"."name_short_code",
    "array_agg"("lu_categories"."description" ORDER BY "lu_categories"."description") AS "descriptions"
   FROM "public"."lu_categories"
  WHERE (("lu_categories"."status" = 'active'::"text") AND ("lu_categories"."type" = 'One Form'::"text"))
  GROUP BY "lu_categories"."name_short_code"
  ORDER BY "lu_categories"."name_short_code";


ALTER TABLE "public"."view_one_form_statements" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_one_form_subcategories" WITH ("security_invoker"='on') AS
 SELECT "sub"."id" AS "subcategory_id",
    "sub"."name" AS "subcategory_name",
    "sub"."status" AS "subcategory_status",
    "sub"."type" AS "subcategory_type",
    COALESCE("sub"."record_level", "cat"."record_level") AS "record_level",
    COALESCE("sub"."record_type", "cat"."record_type") AS "record_type",
    "cat"."id" AS "category_id",
    "cat"."name" AS "category_name",
    "cat"."type" AS "category_type",
    "cat"."status" AS "category_status"
   FROM ("public"."lu_record_subcategories" "sub"
     JOIN "public"."lu_record_categories" "cat" ON (("sub"."record_category_id" = "cat"."id")))
  WHERE ((("sub"."status")::"text" = 'active'::"text") AND (("cat"."status")::"text" = 'active'::"text") AND ("cat"."one_form_statements" = true));


ALTER TABLE "public"."view_one_form_subcategories" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_reports" WITH ("security_invoker"='on') AS
 SELECT "reports"."id",
    "reports"."service_id",
    "reports"."name",
    "reports"."description",
    "reports"."stimulsoft_url",
    "reports"."criteria",
    "reports"."is_visible_on_reports_page",
    "reports"."system_area",
    "reports"."sequence",
    "reports"."is_in_test",
    "reports"."is_slt_only"
   FROM "public"."reports"
  WHERE (("reports"."is_visible_on_reports_page" = true) AND (("reports"."is_slt_only" = false) OR (("reports"."is_slt_only" = true) AND (EXISTS ( SELECT 1
           FROM ("public"."user_roles" "ur"
             JOIN "public"."lu_roles" "lr" ON (("ur"."roleId" = "lr"."id")))
          WHERE (("ur"."userId" = "auth"."uid"()) AND ("lr"."name" = 'SLT'::"text")))))) AND (("reports"."is_in_test" = false) OR (("reports"."is_in_test" = true) AND (EXISTS ( SELECT 1
           FROM ("public"."user_roles" "ur"
             JOIN "public"."lu_roles" "lr" ON (("ur"."roleId" = "lr"."id")))
          WHERE (("ur"."userId" = "auth"."uid"()) AND ("lr"."name" = 'Tester'::"text")))))))
  ORDER BY "reports"."system_area", "reports"."sequence";


ALTER TABLE "public"."view_reports" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_roles" WITH ("security_invoker"='on') AS
 SELECT "lu_roles"."id",
    "lu_roles"."name",
    "lu_roles"."description"
   FROM "public"."lu_roles";


ALTER TABLE "public"."view_roles" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_service_records_summary" WITH ("security_invoker"='on') AS
 SELECT "student_records"."service_id",
    "student_records"."record_type",
    "count"(*) AS "record_count"
   FROM "public"."student_records"
  GROUP BY "student_records"."service_id", "student_records"."record_type";


ALTER TABLE "public"."view_service_records_summary" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_services" WITH ("security_invoker"='on') AS
 SELECT "services"."id",
    "services"."name",
    "services"."description",
    "services"."status",
    "services"."initials",
    "services"."logo_url",
    "services"."regional_email",
    "services"."sg_email"
   FROM "public"."services"
  ORDER BY "services"."name";


ALTER TABLE "public"."view_services" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_status_count" WITH ("security_invoker"='on') AS
 SELECT "sa"."service_id",
    "s"."name" AS "service_name",
    "count"(
        CASE
            WHEN ("sa"."status" = 'On Roll'::"text") THEN 1
            ELSE NULL::integer
        END) AS "on_roll_count",
    "count"(
        CASE
            WHEN ("sa"."status" = 'Pending'::"text") THEN 1
            ELSE NULL::integer
        END) AS "pending_count",
    "count"(
        CASE
            WHEN ("sa"."status" = 'Off Roll'::"text") THEN 1
            ELSE NULL::integer
        END) AS "off_roll_count",
    "count"(*) AS "total_count"
   FROM ("public"."student_admissions" "sa"
     JOIN "public"."services" "s" ON (("sa"."service_id" = "s"."id")))
  GROUP BY "sa"."service_id", "s"."name"
  ORDER BY "s"."name";


ALTER TABLE "public"."view_status_count" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_attendance_info" WITH ("security_invoker"='on') AS
 SELECT "sa"."id",
    "sa"."student_id",
    "sa"."service_id",
    "sa"."term_id",
    "sa"."week_id",
    "sa"."date",
    "sa"."session",
    "sa"."attendance_code_id",
    COALESCE("sa"."comments", ''::"text") AS "comments",
    "sa"."created_at",
    "sa"."created_by",
    "sa"."updated_at",
    "sa"."updated_by",
        CASE
            WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN "concat"("s"."preferred_name", ' ', COALESCE("s"."surname", ''::"text"))
            ELSE "concat"(COALESCE("s"."first_name", ''::"text"), ' ', COALESCE("s"."surname", ''::"text"))
        END AS "student_calculated_name",
    COALESCE("serv"."name", ''::"text") AS "service_name",
    COALESCE("t"."name", (''::"text")::character varying) AS "term_name",
    COALESCE("ay"."name", ''::"text") AS "academic_year_name",
    COALESCE(("w"."week_number")::"text", ''::"text") AS "week_name",
    COALESCE("lc"."name_short_code", ''::"text") AS "attendance_code_name",
    COALESCE("lc"."description", ''::"text") AS "attendance_code_description",
    COALESCE(TRIM(BOTH FROM "concat_ws"(' - '::"text", "lc"."name_short_code", "lc"."description")), ''::"text") AS "attendance_full_description",
    COALESCE(("au_created"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "created_by_user_name",
    COALESCE(("au_updated"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "updated_by_user_name",
    COALESCE(("t"."name")::"text", ''::"text") AS "term_name_year",
    "concat"('Wk ', COALESCE(("w"."week_number")::"text", ''::"text"), ': ', "to_char"(("w"."week_start")::timestamp with time zone, 'DD/MM/YYYY'::"text"), '-', "to_char"(("w"."week_end")::timestamp with time zone, 'DD/MM/YYYY'::"text")) AS "week_name_date_range",
    "sa_current"."local_authority_id",
    COALESCE("la_org"."organisation_name", ''::"text") AS "local_authority_name"
   FROM (((((((((("public"."student_attendance" "sa"
     LEFT JOIN "public"."students" "s" ON (("sa"."student_id" = "s"."id")))
     LEFT JOIN "public"."services" "serv" ON (("sa"."service_id" = "serv"."id")))
     LEFT JOIN "public"."terms" "t" ON (("sa"."term_id" = "t"."id")))
     LEFT JOIN "public"."lu_academic_years" "ay" ON (("t"."academic_year_id" = "ay"."id")))
     LEFT JOIN "public"."weeks" "w" ON (("sa"."week_id" = "w"."id")))
     LEFT JOIN "public"."lu_categories" "lc" ON (("sa"."attendance_code_id" = "lc"."id")))
     LEFT JOIN "auth"."users" "au_created" ON (("sa"."created_by" = "au_created"."id")))
     LEFT JOIN "auth"."users" "au_updated" ON (("sa"."updated_by" = "au_updated"."id")))
     LEFT JOIN "public"."student_admissions" "sa_current" ON ((("sa"."student_id" = "sa_current"."student_id") AND ("sa_current"."is_current" = true))))
     LEFT JOIN "public"."organisations" "la_org" ON (("sa_current"."local_authority_id" = "la_org"."id")));


ALTER TABLE "public"."view_student_attendance_info" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_attendance_summary" WITH ("security_invoker"='on') AS
 WITH "attendance_counts" AS (
         SELECT "sa"."student_id",
            "sa"."service_id",
            "sa"."term_id",
            "t_1"."academic_year_id",
            "sa_current"."local_authority_id",
            "count"(*) AS "total_sessions",
            "sum"(
                CASE
                    WHEN ("ac_1"."present" = true) THEN 1
                    ELSE 0
                END) AS "present_count",
            "sum"(
                CASE
                    WHEN ("ac_1"."c_authorised" = true) THEN 1
                    ELSE 0
                END) AS "c_authorised_count",
            "sum"(
                CASE
                    WHEN (("ac_1"."authorised" = true) AND ("ac_1"."c_authorised" IS NOT TRUE)) THEN 1
                    ELSE 0
                END) AS "authorised_count",
            "sum"(
                CASE
                    WHEN ("ac_1"."unauthorised" = true) THEN 1
                    ELSE 0
                END) AS "unauthorised_count",
            "sum"(
                CASE
                    WHEN ("ac_1"."admin" = true) THEN 1
                    ELSE 0
                END) AS "admin_count"
           FROM ((("public"."student_attendance" "sa"
             JOIN "public"."terms" "t_1" ON (("sa"."term_id" = "t_1"."id")))
             JOIN "public"."view_attendance_codes" "ac_1" ON (("sa"."attendance_code_id" = "ac_1"."id")))
             JOIN "public"."student_admissions" "sa_current" ON ((("sa"."student_id" = "sa_current"."student_id") AND ("sa_current"."is_current" = true))))
          GROUP BY "sa"."student_id", "sa"."service_id", "sa"."term_id", "t_1"."academic_year_id", "sa_current"."local_authority_id"
        )
 SELECT "ac"."student_id",
    "ac"."service_id",
    "ac"."term_id",
    "ac"."academic_year_id",
    "ac"."local_authority_id",
    "serv"."name" AS "service_name",
    "la_org"."organisation_name" AS "local_authority_name",
    "t"."name" AS "term_name",
    "ay"."name" AS "academic_year_name",
        CASE
            WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN "concat"("s"."preferred_name", ' ', COALESCE("s"."surname", ''::"text"))
            ELSE "concat"(COALESCE("s"."first_name", ''::"text"), ' ', COALESCE("s"."surname", ''::"text"))
        END AS "student_name",
    "round"(((("ac"."present_count")::numeric / ("ac"."total_sessions")::numeric) * (100)::numeric), 1) AS "present_percentage",
    "round"(((("ac"."c_authorised_count")::numeric / ("ac"."total_sessions")::numeric) * (100)::numeric), 1) AS "c_authorised_percentage",
    "round"(((("ac"."authorised_count")::numeric / ("ac"."total_sessions")::numeric) * (100)::numeric), 1) AS "authorised_percentage",
    "round"(((("ac"."unauthorised_count")::numeric / ("ac"."total_sessions")::numeric) * (100)::numeric), 1) AS "unauthorised_percentage",
    "round"(((("ac"."admin_count")::numeric / ("ac"."total_sessions")::numeric) * (100)::numeric), 1) AS "admin_percentage",
    "ac"."total_sessions",
    "ac"."present_count",
    "ac"."c_authorised_count",
    "ac"."authorised_count",
    "ac"."unauthorised_count",
    "ac"."admin_count"
   FROM ((((("attendance_counts" "ac"
     JOIN "public"."services" "serv" ON (("ac"."service_id" = "serv"."id")))
     JOIN "public"."organisations" "la_org" ON (("ac"."local_authority_id" = "la_org"."id")))
     JOIN "public"."terms" "t" ON (("ac"."term_id" = "t"."id")))
     JOIN "public"."lu_academic_years" "ay" ON (("ac"."academic_year_id" = "ay"."id")))
     JOIN "public"."students" "s" ON (("ac"."student_id" = "s"."id")))
  ORDER BY "serv"."name", "la_org"."organisation_name", "t"."name",
        CASE
            WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN "concat"("s"."preferred_name", ' ', COALESCE("s"."surname", ''::"text"))
            ELSE "concat"(COALESCE("s"."first_name", ''::"text"), ' ', COALESCE("s"."surname", ''::"text"))
        END;


ALTER TABLE "public"."view_student_attendance_summary" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_contacts_info" WITH ("security_invoker"='on') AS
 WITH "student_full_name" AS (
         SELECT "students"."id",
            TRIM(BOTH FROM "concat_ws"(' '::"text", "students"."first_name", NULLIF("students"."middle_name", ''::"text"), "students"."surname")) AS "full_name"
           FROM "public"."students"
        )
 SELECT "sc"."id" AS "student_contact_id",
    "s"."id" AS "student_id",
    COALESCE("s"."first_name", ''::"text") AS "student_first_name",
    COALESCE("s"."surname", ''::"text") AS "student_surname",
    COALESCE("sfn"."full_name", ''::"text") AS "student_full_name",
    "srv"."id" AS "service_id",
    COALESCE("srv"."name", ''::"text") AS "service_name",
    COALESCE("sc"."relationship", ''::"text") AS "relationship",
    COALESCE("sc"."emergency_contact", false) AS "emergency_contact",
    COALESCE("sc"."lives_with_this_contact", false) AS "lives_with_this_contact",
    COALESCE("sc"."parental_responsibility", false) AS "parental_responsibility",
    "c"."id" AS "contact_id",
    TRIM(BOTH FROM "concat_ws"(' '::"text", "c"."first_name", "c"."last_name")) AS "full_name",
    COALESCE("c"."first_name", ''::"text") AS "contact_first_name",
    COALESCE("c"."last_name", ''::"text") AS "contact_last_name",
    COALESCE("c"."job_title", ''::"text") AS "job_title",
    COALESCE("c"."department", ''::"text") AS "department",
    COALESCE("c"."email", ''::"text") AS "email",
    COALESCE("c"."landline", ''::"text") AS "landline",
    COALESCE("c"."mobile", ''::"text") AS "mobile",
    COALESCE("c"."address_line1", ''::"text") AS "address_line1",
    COALESCE("c"."address_line2", ''::"text") AS "address_line2",
    COALESCE("c"."address_line3", ''::"text") AS "address_line3",
    COALESCE("c"."address_town", ''::"text") AS "address_town",
    COALESCE("c"."address_postcode", ''::"text") AS "address_postcode",
    COALESCE("c"."address_county", ''::"text") AS "address_county",
    TRIM(BOTH FROM "concat_ws"(', '::"text", NULLIF("c"."address_line1", ''::"text"), NULLIF("c"."address_line2", ''::"text"), NULLIF("c"."address_line3", ''::"text"), NULLIF("c"."address_town", ''::"text"), NULLIF("c"."address_county", ''::"text"), NULLIF("c"."address_postcode", ''::"text"))) AS "full_address",
    COALESCE("c"."comments", ''::"text") AS "contact_comments",
    COALESCE("c"."status", ''::"text") AS "contact_status",
    "o"."id" AS "organisation_id",
    COALESCE("o"."organisation_name", ''::"text") AS "organisation_name",
    "sc"."created_at" AS "relationship_created_at",
    "sc"."updated_at" AS "relationship_updated_at",
    COALESCE("au"."email", ''::character varying) AS "created_by_email"
   FROM (((((("public"."student_contacts" "sc"
     JOIN "public"."students" "s" ON (("sc"."student_id" = "s"."id")))
     JOIN "student_full_name" "sfn" ON (("s"."id" = "sfn"."id")))
     JOIN "public"."services" "srv" ON (("sc"."service_id" = "srv"."id")))
     JOIN "public"."contacts" "c" ON (("sc"."contact_id" = "c"."id")))
     LEFT JOIN "public"."organisations" "o" ON (("c"."organisation_id" = "o"."id")))
     LEFT JOIN "auth"."users" "au" ON (("sc"."created_by" = "au"."id")));


ALTER TABLE "public"."view_student_contacts_info" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_info" AS
SELECT
    NULL::"uuid" AS "student_id",
    NULL::"text" AS "colour_code",
    NULL::"text" AS "name",
    NULL::"text" AS "first_name",
    NULL::"text" AS "middle_name",
    NULL::"text" AS "surname",
    NULL::"text" AS "full_name",
    NULL::"text" AS "preferred_name",
    NULL::"text" AS "calculated_name",
    NULL::"text" AS "initials",
    NULL::"uuid" AS "service_id",
    NULL::"text" AS "service_name",
    NULL::"uuid" AS "student_admission_id",
    NULL::"text" AS "status",
    NULL::"date" AS "start_date",
    NULL::"date" AS "end_date",
    NULL::"date" AS "dob",
    NULL::boolean AS "sg_data_sent",
    NULL::"uuid" AS "last_school_attended_id",
    NULL::"uuid" AS "local_authority_id",
    NULL::"text" AS "nationality",
    NULL::"text" AS "ethnicity",
    NULL::"text" AS "religion",
    NULL::"text" AS "current_home_address1",
    NULL::"text" AS "current_home_address2",
    NULL::"text" AS "current_home_address3",
    NULL::"text" AS "current_home_postcode",
    NULL::"text" AS "current_home_town",
    NULL::"text" AS "current_home_county",
    NULL::"text" AS "previous_home_address1",
    NULL::"text" AS "previous_home_address2",
    NULL::"text" AS "previous_home_address3",
    NULL::"text" AS "previous_home_town",
    NULL::"text" AS "previous_home_postcode",
    NULL::"text" AS "previous_home_county",
    NULL::"text" AS "previous_placement_additional_info",
    NULL::"text" AS "uln_uci",
    NULL::"text" AS "destination",
    NULL::"text" AS "sex",
    NULL::"text" AS "gender_identity",
    NULL::"text" AS "placing_authority",
    NULL::"text" AS "last_school_attended",
    NULL::"text"[] AS "groups",
    NULL::"text"[] AS "tags",
    NULL::double precision AS "calculated_age",
    NULL::"text" AS "base_group_name",
    NULL::"text" AS "teacher_name",
    NULL::"text" AS "cc_name",
    NULL::"text" AS "rsl_name",
    NULL::bigint AS "student_relational_count",
    NULL::bigint AS "student_admissions_count",
    NULL::bigint AS "student_sb_needs_count",
    NULL::bigint AS "student_ehcp_needs_count",
    NULL::"text" AS "admission_created_at",
    NULL::"text" AS "admission_updated_at",
    NULL::"text" AS "admission_created_by_name",
    NULL::"text" AS "admission_updated_by_name",
    NULL::"jsonb" AS "emergency_contacts";


ALTER TABLE "public"."view_student_info" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_emergency_countact_numbers" AS
 SELECT "sc"."student_id",
    "sc"."student_full_name",
    "count"("sc"."emergency_contact") AS "number_of_emergency_contacts",
    "sc"."service_id",
    "sc"."service_name",
    "si"."base_group_name",
    "si"."status"
   FROM ("public"."view_student_contacts_info" "sc"
     JOIN "public"."view_student_info" "si" ON ((("sc"."student_id" = "si"."student_id") AND ("si"."status" = 'On Roll'::"text"))))
  GROUP BY "sc"."student_id", "sc"."student_full_name", "sc"."service_id", "sc"."service_name", "si"."base_group_name", "si"."status";


ALTER TABLE "public"."view_student_emergency_countact_numbers" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_events_info" WITH ("security_invoker"='on') AS
 SELECT "se"."id",
    "se"."student_id",
    "se"."service_id",
    "se"."template_id",
    "se"."parent_event_id",
    COALESCE("se"."follow_up_order", 0) AS "follow_up_order",
    "se"."start_date",
    "se"."end_date",
    "se"."start_time",
    "se"."end_time",
    "se"."url",
    COALESCE(((("se"."start_date")::"text" || ' '::"text") || ("se"."start_time")::"text"), ("se"."start_date")::"text") AS "start_datetime",
    COALESCE(((("se"."end_date")::"text" || ' '::"text") || ("se"."end_time")::"text"), ("se"."end_date")::"text") AS "end_datetime",
    COALESCE("se"."status", ''::"text") AS "status",
    "se"."created_by",
    "se"."created_at",
    "se"."updated_at",
    COALESCE("se"."title", ''::"text") AS "title",
    COALESCE("se"."description", ''::"text") AS "description",
    COALESCE("se"."all_day", false) AS "all_day",
    COALESCE("se"."url", ''::"text") AS "event_link_url",
    COALESCE("lc"."name_short_code", ''::"text") AS "category_short_code",
    COALESCE("s"."name", ''::"text") AS "student_name",
    COALESCE("s"."first_name", ''::"text") AS "student_first_name",
    COALESCE("s"."middle_name", ''::"text") AS "student_middle_name",
    COALESCE("s"."surname", ''::"text") AS "student_surname",
    COALESCE(TRIM(BOTH FROM "concat_ws"(' '::"text", "s"."first_name", NULLIF("s"."middle_name", ''::"text"), "s"."surname")), ''::"text") AS "student_full_name",
    COALESCE("s"."preferred_name", ''::"text") AS "student_preferred_name",
        CASE
            WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN "concat"("s"."preferred_name", ' ', COALESCE("s"."surname", ''::"text"))
            ELSE "concat"(COALESCE("s"."first_name", ''::"text"), ' ', COALESCE("s"."surname", ''::"text"))
        END AS "student_calculated_name",
    COALESCE("et"."name", ''::"text") AS "event_template_name",
    COALESCE("et"."description", ''::"text") AS "event_template_description",
    COALESCE("et"."has_follow_ups", false) AS "has_follow_ups",
    COALESCE("et"."duration", 0) AS "event_duration",
    COALESCE("et"."interval_days", 0) AS "event_interval_days",
    COALESCE("serv"."name", ''::"text") AS "service_name",
    COALESCE("lc"."name_short_code", ''::"text") AS "event_category_short_code",
    COALESCE(("au_created"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "created_by_user_name",
    COALESCE(("au_updated"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "updated_by_user_name"
   FROM (((((("public"."student_events" "se"
     LEFT JOIN "public"."event_templates" "et" ON (("se"."template_id" = "et"."id")))
     LEFT JOIN "public"."lu_categories" "lc" ON (("et"."category_id" = "lc"."id")))
     LEFT JOIN "public"."students" "s" ON (("se"."student_id" = "s"."id")))
     LEFT JOIN "public"."services" "serv" ON (("se"."service_id" = "serv"."id")))
     LEFT JOIN "auth"."users" "au_created" ON (("se"."created_by" = "au_created"."id")))
     LEFT JOIN "auth"."users" "au_updated" ON (("se"."updated_by" = "au_updated"."id")));


ALTER TABLE "public"."view_student_events_info" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_info_grid" AS
SELECT
    NULL::"uuid" AS "student_id",
    NULL::"text" AS "calculated_name",
    NULL::"text" AS "initials",
    NULL::"text"[] AS "tags",
    NULL::"date" AS "date_of_birth",
    NULL::double precision AS "age",
    NULL::"text"[] AS "groups",
    NULL::"text" AS "placing_authority",
    NULL::"date" AS "start_date",
    NULL::"date" AS "end_date",
    NULL::"text" AS "status",
    NULL::"text" AS "service_name",
    NULL::"uuid" AS "service_id";


ALTER TABLE "public"."view_student_info_grid" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_links" WITH ("security_invoker"='on') AS
 SELECT "l"."id",
    "l"."student_id",
    "l"."url",
    "l"."name",
    "l"."type",
    "l"."description",
    "l"."service_id",
    "s"."name" AS "service_name",
        CASE
            WHEN (COALESCE("st"."preferred_name", ''::"text") <> ''::"text") THEN ((COALESCE("st"."preferred_name", ''::"text") || ' '::"text") || COALESCE("st"."surname", ''::"text"))
            ELSE ((COALESCE("st"."first_name", ''::"text") || ' '::"text") || COALESCE("st"."surname", ''::"text"))
        END AS "calculated_name"
   FROM (("public"."links" "l"
     JOIN "public"."services" "s" ON (("l"."service_id" = "s"."id")))
     JOIN "public"."students" "st" ON (("l"."student_id" = "st"."id")));


ALTER TABLE "public"."view_student_links" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_missing_address" WITH ("security_invoker"='on') AS
 SELECT "si"."student_id",
    "si"."full_name",
    "si"."service_name",
    "si"."base_group_name",
    "si"."status",
    "si"."service_id"
   FROM "public"."view_student_info" "si"
  WHERE (("si"."current_home_address1" = ''::"text") AND ("si"."current_home_address2" = ''::"text") AND ("si"."status" = 'On Roll'::"text") AND ("si"."service_id" <> '7b096f39-3e4b-4392-8a95-63635443c3b4'::"uuid"));


ALTER TABLE "public"."view_student_missing_address" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_missing_base_group_name" WITH ("security_invoker"='on') AS
 SELECT "si"."student_id",
    "si"."full_name",
    "si"."service_name",
    "si"."base_group_name",
    "si"."status",
    "si"."service_id"
   FROM "public"."view_student_info" "si"
  WHERE (("si"."service_id" <> '7b096f39-3e4b-4392-8a95-63635443c3b4'::"uuid") AND ("si"."status" = 'On Roll'::"text") AND ("si"."base_group_name" IS NULL));


ALTER TABLE "public"."view_student_missing_base_group_name" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_missing_dob" WITH ("security_invoker"='on') AS
 SELECT "si"."student_id",
    "si"."full_name",
    "si"."service_name",
    "si"."base_group_name",
    "si"."status",
    "si"."service_id"
   FROM "public"."view_student_info" "si"
  WHERE (("si"."service_id" <> '7b096f39-3e4b-4392-8a95-63635443c3b4'::"uuid") AND ("si"."status" = 'On Roll'::"text") AND ("si"."dob" IS NULL));


ALTER TABLE "public"."view_student_missing_dob" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_needsoutcomes" WITH ("security_invoker"='on') AS
 SELECT "sno"."id",
    "sno"."created_at",
    "sno"."service_id",
    "sno"."student_id",
    "sno"."ehcp_category_id",
    "lc"."name_short_code" AS "ehcp_category_short_code",
    "sno"."description",
    "sno"."source",
    "sno"."status",
    "sno"."type",
    "sno"."when",
    "s"."first_name",
    "s"."surname",
    "s"."preferred_name",
        CASE
            WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN ((COALESCE("s"."preferred_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
            ELSE ((COALESCE("s"."first_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
        END AS "calculated_name",
    "sno"."created_date",
    "sno"."created_by",
    ("creator"."raw_user_meta_data" ->> 'name'::"text") AS "created_by_name",
    "sno"."updated_date",
    "sno"."updated_by",
    ("updater"."raw_user_meta_data" ->> 'name'::"text") AS "updated_by_name"
   FROM (((("public"."student_needsoutcomes" "sno"
     JOIN "public"."lu_categories" "lc" ON (("sno"."ehcp_category_id" = "lc"."id")))
     JOIN "public"."students" "s" ON (("sno"."student_id" = "s"."id")))
     LEFT JOIN "auth"."users" "creator" ON (("sno"."created_by" = "creator"."id")))
     LEFT JOIN "auth"."users" "updater" ON (("sno"."updated_by" = "updater"."id")));


ALTER TABLE "public"."view_student_needsoutcomes" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_records" WITH ("security_invoker"='on') AS
 SELECT "original_view"."id",
    "original_view"."lookup",
    "original_view"."service_id",
    "original_view"."contact_id",
    "original_view"."service_name",
    "original_view"."student_id",
    "original_view"."student_name",
    "original_view"."record_type",
    "original_view"."record_category_id",
    "original_view"."record_category_name",
    "original_view"."record_subcategory_id",
    "original_view"."record_subcategory_name",
    "original_view"."academic_year_id",
    "original_view"."academic_year_name",
    "original_view"."term_id",
    "original_view"."term_name",
    "original_view"."date",
    "original_view"."details",
    "original_view"."status",
    "original_view"."entry_id",
    "original_view"."auto_increment",
    "original_view"."is_confidential",
    "original_view"."other_students",
    "original_view"."other_staff",
    "original_view"."other_external",
    "original_view"."star_recording",
    "original_view"."created_at",
    "original_view"."updated_at",
    "original_view"."created_by",
    "original_view"."updated_by",
    "original_view"."record_date",
    "original_view"."risk_level",
    "original_view"."risk_score",
    "original_view"."review_date",
    "original_view"."is_child_on_child",
    "original_view"."is_esafety",
    "original_view"."is_bullying",
    "original_view"."legacy_data",
    "original_view"."incident_data",
    "original_view"."safeguarding_data",
    "original_view"."actions_required",
    "original_view"."pi_data",
    "original_view"."notifications_data",
    "original_view"."review_completed",
    "original_view"."staff_feedback_provided",
    "original_view"."evidence_location",
    "original_view"."serial_no",
    "original_view"."needs_data",
    "original_view"."new_statement",
    "original_view"."students_injured",
    "original_view"."staff_injured",
    "original_view"."is_students_injured",
    "original_view"."is_staff_injured",
    "original_view"."is_pi",
    "original_view"."completed_by",
    "original_view"."sg_category_name",
    "original_view"."sg_subcategory_name",
    "original_view"."status_changed_by",
    "original_view"."status_changed_by_name",
    "original_view"."review_count",
    "original_view"."action_count"
   FROM ( SELECT "sr"."id",
            "sr"."lookup",
            "sr"."service_id",
            "sr"."contact_id",
            "s"."name" AS "service_name",
            "sr"."student_id",
                CASE
                    WHEN (COALESCE("st"."preferred_name", ''::"text") <> ''::"text") THEN "concat"("st"."preferred_name", ' ', "st"."surname")
                    ELSE COALESCE(TRIM(BOTH FROM "concat_ws"(' '::"text", "st"."first_name", "st"."middle_name", "st"."surname")), ''::"text")
                END AS "student_name",
            "sr"."record_type",
            "sr"."record_category_id",
            "lrc"."name" AS "record_category_name",
            "sr"."record_subcategory_id",
            "lrsc"."name" AS "record_subcategory_name",
            "sr"."academic_year_id",
            "lay"."name" AS "academic_year_name",
            "sr"."term_id",
            "lt"."name" AS "term_name",
            "sr"."date",
            "sr"."details",
            "sr"."status",
            "sr"."entry_id",
            "sr"."auto_increment",
            "sr"."is_confidential",
            "sr"."other_students",
            "sr"."other_staff",
            "sr"."other_external",
            "sr"."star_recording",
            "sr"."created_at",
            "sr"."updated_at",
            "sr"."created_by",
            "sr"."updated_by",
            "sr"."record_date",
            "sr"."risk_level",
            "sr"."risk_score",
            "sr"."review_date",
            "sr"."is_child_on_child",
            "sr"."is_esafety",
            "sr"."is_bullying",
            "sr"."legacy_data",
            "sr"."incident_data",
            "sr"."safeguarding_data",
            "sr"."actions_required",
            "sr"."pi_data",
            "sr"."notifications_data",
            "sr"."review_completed",
            "sr"."staff_feedback_provided",
            "sr"."evidence_location",
            "sr"."serial_no",
            "sr"."needs_data",
            "sr"."new_statement",
            "sr"."students_injured",
            "sr"."staff_injured",
            "sr"."is_students_injured",
            "sr"."is_staff_injured",
            "sr"."is_pi",
            COALESCE(("u"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "completed_by",
            "sg_cat"."name" AS "sg_category_name",
            "sg_subcat"."name" AS "sg_subcategory_name",
            "sr"."status_changed_by",
            COALESCE(("u_status_changed"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "status_changed_by_name",
            COALESCE("review_count"."count", (0)::bigint) AS "review_count",
            COALESCE("action_count"."count", (0)::bigint) AS "action_count"
           FROM (((((((((((("public"."student_records" "sr"
             JOIN "public"."services" "s" ON (("sr"."service_id" = "s"."id")))
             JOIN "public"."students" "st" ON (("sr"."student_id" = "st"."id")))
             LEFT JOIN "public"."lu_record_categories" "lrc" ON (("sr"."record_category_id" = "lrc"."id")))
             LEFT JOIN "public"."lu_record_subcategories" "lrsc" ON (("sr"."record_subcategory_id" = "lrsc"."id")))
             LEFT JOIN "public"."lu_academic_years" "lay" ON (("sr"."academic_year_id" = "lay"."id")))
             LEFT JOIN "auth"."users" "u" ON (("sr"."created_by" = "u"."id")))
             LEFT JOIN "auth"."users" "u_status_changed" ON (("sr"."status_changed_by" = "u_status_changed"."id")))
             LEFT JOIN "public"."lu_terms" "lt" ON (("sr"."term_id" = "lt"."id")))
             LEFT JOIN "public"."lu_record_categories" "sg_cat" ON ((
                CASE
                    WHEN ((("sr"."safeguarding_data" ->> 'sg_Category'::"text") IS NOT NULL) AND (("sr"."safeguarding_data" ->> 'sg_Category'::"text") ~ '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'::"text")) THEN (("sr"."safeguarding_data" ->> 'sg_Category'::"text"))::"uuid"
                    ELSE NULL::"uuid"
                END = "sg_cat"."id")))
             LEFT JOIN "public"."lu_record_subcategories" "sg_subcat" ON ((
                CASE
                    WHEN ((("sr"."safeguarding_data" ->> 'sg_SubCategory'::"text") IS NOT NULL) AND (("sr"."safeguarding_data" ->> 'sg_SubCategory'::"text") ~ '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'::"text")) THEN (("sr"."safeguarding_data" ->> 'sg_SubCategory'::"text"))::"uuid"
                    ELSE NULL::"uuid"
                END = "sg_subcat"."id")))
             LEFT JOIN ( SELECT "student_records_reviews"."student_record_id",
                    "count"(*) AS "count"
                   FROM "public"."student_records_reviews"
                  GROUP BY "student_records_reviews"."student_record_id") "review_count" ON (("sr"."id" = "review_count"."student_record_id")))
             LEFT JOIN ( SELECT "actions"."student_record_id",
                    "count"(*) AS "count"
                   FROM "public"."actions"
                  GROUP BY "actions"."student_record_id") "action_count" ON (("sr"."id" = "action_count"."student_record_id")))
          WHERE (("sr"."status")::"text" <> 'inactive'::"text")) "original_view"
  WHERE ((("auth"."uid"() IS NULL) AND (CURRENT_USER = 'postgres'::"name")) OR (((("original_view"."record_type")::"text" <> 'Safeguarding'::"text") AND ("original_view"."is_confidential" = false)) OR ((((("original_view"."record_type")::"text" = 'Safeguarding'::"text") OR ("original_view"."is_confidential" = true)) AND (EXISTS ( SELECT 1
           FROM ("public"."user_roles" "ur"
             JOIN "public"."lu_roles" "lr" ON (("ur"."roleId" = "lr"."id")))
          WHERE (("ur"."userId" = "auth"."uid"()) AND ("ur"."service_id" = "original_view"."service_id") AND ("lr"."name" = 'SLT'::"text"))))) OR (EXISTS ( SELECT 1
           FROM "public"."confidential_access" "ca"
          WHERE (("ca"."user_id" = "auth"."uid"()) AND ("ca"."student_record_id" = "original_view"."id") AND ("ca"."revoked_at" IS NULL)))))));


ALTER TABLE "public"."view_student_records" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_records_grid" WITH ("security_invoker"='on') AS
 SELECT "original_grid_view"."service_id",
    "original_grid_view"."service_name",
    "original_grid_view"."date",
    "original_grid_view"."created_by",
    "original_grid_view"."student_name",
    "original_grid_view"."type",
    "original_grid_view"."timestamp",
    "original_grid_view"."combined_id",
    "original_grid_view"."details",
    "original_grid_view"."status",
    "original_grid_view"."completed_by",
    "original_grid_view"."student_id",
    "original_grid_view"."id",
    "original_grid_view"."review_count",
    "original_grid_view"."action_count",
    "original_grid_view"."academic_year_id",
    "original_grid_view"."academic_year_name",
    "original_grid_view"."term_id",
    "original_grid_view"."term_name",
    "original_grid_view"."risk_level",
    "original_grid_view"."is_pi"
   FROM ( SELECT "sr"."service_id",
            "s"."name" AS "service_name",
            "sr"."date",
            "sr"."created_by",
            "st"."name" AS "student_name",
            "sr"."record_type" AS "type",
            "to_char"("sr"."created_at", 'DD/MM/YYYY HH24:MI:SS'::"text") AS "timestamp",
            COALESCE("sr"."lookup",
                CASE
                    WHEN ("sr"."serial_no" IS NOT NULL) THEN (((("sr"."record_type")::"text" || '-'::"text") || ("sr"."serial_no")::"text"))::character varying
                    ELSE "sr"."entry_id"
                END) AS "combined_id",
            "sr"."details",
            "sr"."status",
            COALESCE(("u"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "completed_by",
            "sr"."student_id",
            "sr"."id",
            COALESCE("review_count"."count", (0)::bigint) AS "review_count",
            COALESCE("action_count"."count", (0)::bigint) AS "action_count",
            "sr"."is_confidential",
            "sr"."academic_year_id",
            "lay"."name" AS "academic_year_name",
            "sr"."term_id",
            "lt"."name" AS "term_name",
            "sr"."risk_level",
            "sr"."is_pi"
           FROM ((((((("public"."student_records" "sr"
             JOIN "public"."services" "s" ON (("sr"."service_id" = "s"."id")))
             JOIN "public"."students" "st" ON (("sr"."student_id" = "st"."id")))
             LEFT JOIN "auth"."users" "u" ON (("sr"."created_by" = "u"."id")))
             LEFT JOIN "public"."lu_academic_years" "lay" ON (("sr"."academic_year_id" = "lay"."id")))
             LEFT JOIN "public"."lu_terms" "lt" ON (("sr"."term_id" = "lt"."id")))
             LEFT JOIN ( SELECT "student_records_reviews"."student_record_id",
                    "count"(*) AS "count"
                   FROM "public"."student_records_reviews"
                  GROUP BY "student_records_reviews"."student_record_id") "review_count" ON (("sr"."id" = "review_count"."student_record_id")))
             LEFT JOIN ( SELECT "actions"."student_record_id",
                    "count"(*) AS "count"
                   FROM "public"."actions"
                  GROUP BY "actions"."student_record_id") "action_count" ON (("sr"."id" = "action_count"."student_record_id")))
          WHERE (("sr"."status")::"text" <> 'inactive'::"text")
          ORDER BY "sr"."date" DESC, "sr"."created_at" DESC) "original_grid_view"
  WHERE ((("auth"."uid"() IS NULL) AND (CURRENT_USER = 'postgres'::"name")) OR (((("original_grid_view"."type")::"text" <> 'Safeguarding'::"text") AND ("original_grid_view"."is_confidential" = false)) OR ((((("original_grid_view"."type")::"text" = 'Safeguarding'::"text") OR ("original_grid_view"."is_confidential" = true)) AND (EXISTS ( SELECT 1
           FROM ("public"."user_roles" "ur"
             JOIN "public"."lu_roles" "lr" ON (("ur"."roleId" = "lr"."id")))
          WHERE (("ur"."userId" = "auth"."uid"()) AND ("ur"."service_id" = "original_grid_view"."service_id") AND ("lr"."name" = 'SLT'::"text"))))) OR (EXISTS ( SELECT 1
           FROM "public"."confidential_access" "ca"
          WHERE (("ca"."user_id" = "auth"."uid"()) AND ("ca"."student_record_id" = "original_grid_view"."id") AND ("ca"."revoked_at" IS NULL)))))))
  ORDER BY "original_grid_view"."date" DESC, "original_grid_view"."timestamp" DESC;


ALTER TABLE "public"."view_student_records_grid" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_records_kpis" WITH ("security_invoker"='on') AS
 SELECT "student_records"."service_id",
    "student_records"."date",
    "student_records"."record_type",
    "student_records"."risk_level",
    "count"("student_records"."id") AS "total_records",
    "count"(
        CASE
            WHEN (("student_records"."record_type")::"text" = 'Incident'::"text") THEN 1
            ELSE NULL::integer
        END) AS "incident_count",
    "count"(
        CASE
            WHEN (("student_records"."record_type")::"text" = 'Safeguarding'::"text") THEN 1
            ELSE NULL::integer
        END) AS "safeguarding_count",
    "count"(
        CASE
            WHEN (("student_records"."record_type")::"text" = 'Welfare'::"text") THEN 1
            ELSE NULL::integer
        END) AS "welfare_count",
    "count"(
        CASE
            WHEN (("student_records"."record_type")::"text" = 'PI'::"text") THEN 1
            ELSE NULL::integer
        END) AS "old_pi_count",
    "count"(
        CASE
            WHEN ("student_records"."is_pi" = true) THEN 1
            ELSE NULL::integer
        END) AS "pi_count",
    "count"(
        CASE
            WHEN (("student_records"."record_type")::"text" = 'Log'::"text") THEN 1
            ELSE NULL::integer
        END) AS "log_count",
    "count"(
        CASE
            WHEN ("student_records"."risk_level" = 'Level 1'::"text") THEN 1
            ELSE NULL::integer
        END) AS "level_one_count",
    "count"(
        CASE
            WHEN ("student_records"."risk_level" = 'Level 2'::"text") THEN 1
            ELSE NULL::integer
        END) AS "level_two_count",
    "count"(
        CASE
            WHEN ("student_records"."risk_level" = 'Level 3'::"text") THEN 1
            ELSE NULL::integer
        END) AS "level_three_count",
    "count"(
        CASE
            WHEN ("student_records"."risk_level" = 'Level 4'::"text") THEN 1
            ELSE NULL::integer
        END) AS "level_four_count",
    "count"(
        CASE
            WHEN ("student_records"."risk_level" = 'Level 5'::"text") THEN 1
            ELSE NULL::integer
        END) AS "level_five_count",
    "count"(
        CASE
            WHEN ("student_records"."risk_level" IS NOT NULL) THEN 1
            ELSE NULL::integer
        END) AS "total_risk_level_count"
   FROM "public"."student_records"
  WHERE (("student_records"."status")::"text" <> 'inactive'::"text")
  GROUP BY "student_records"."service_id", "student_records"."record_type", "student_records"."risk_level", "student_records"."date";


ALTER TABLE "public"."view_student_records_kpis" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_records_needs" WITH ("security_invoker"='on') AS
 SELECT "srn"."id" AS "student_record_need_id",
    "srn"."student_record_id",
    "srn"."student_needoutcome_id",
    "srn"."created_at" AS "link_created_at",
    "sr"."lookup" AS "record_lookup",
    "sr"."service_id",
    "sr"."student_id",
    "sr"."record_type",
    "sr"."record_category_id",
    "sr"."record_subcategory_id",
    "sr"."academic_year_id",
    "sr"."term_id",
    "sr"."date" AS "record_date",
    "sr"."details" AS "record_details",
    "sr"."status" AS "record_status",
    "sr"."is_confidential",
    "sr"."risk_level",
    "sr"."risk_score",
    "sr"."review_date",
    "sr"."is_child_on_child",
    "sr"."is_esafety",
    "sr"."is_bullying",
    "sno"."description" AS "need_description",
    "sno"."source" AS "need_source",
    "sno"."status" AS "need_status",
    "sno"."type" AS "need_type",
    "sno"."when" AS "need_when",
    "sno"."ehcp_category_id",
    "lc"."name_short_code" AS "ehcp_category_code"
   FROM ((("public"."student_records_needs" "srn"
     JOIN "public"."student_records" "sr" ON (("srn"."student_record_id" = "sr"."id")))
     JOIN "public"."student_needsoutcomes" "sno" ON (("srn"."student_needoutcome_id" = "sno"."id")))
     LEFT JOIN "public"."lu_categories" "lc" ON (("sno"."ehcp_category_id" = "lc"."id")));


ALTER TABLE "public"."view_student_records_needs" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_records_reviews" WITH ("security_invoker"='on') AS
 SELECT "srr"."id" AS "review_id",
    "srr"."created_at" AS "review_created_at",
    "srr"."created_by" AS "review_created_by",
    "srr"."type" AS "review_type",
    "srr"."reflection",
    "srr"."doc_changes",
    "srr"."student_record_id",
    "srr"."date" AS "review_date",
    "sr"."lookup" AS "student_record_lookup",
    "sr"."student_id",
        CASE
            WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN ((COALESCE("s"."preferred_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
            ELSE ((COALESCE("s"."first_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
        END AS "calculated_name",
    "sr"."service_id",
    "serv"."name" AS "service_name",
    ("u"."raw_user_meta_data" ->> 'full_name'::"text") AS "created_by_name"
   FROM (((("public"."student_records_reviews" "srr"
     JOIN "public"."student_records" "sr" ON (("srr"."student_record_id" = "sr"."id")))
     LEFT JOIN "public"."students" "s" ON (("sr"."student_id" = "s"."id")))
     LEFT JOIN "public"."services" "serv" ON (("sr"."service_id" = "serv"."id")))
     LEFT JOIN "auth"."users" "u" ON (("srr"."created_by" = "u"."id")));


ALTER TABLE "public"."view_student_records_reviews" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_records_summary" WITH ("security_invoker"='on') AS
 SELECT "student_records"."service_id",
    "student_records"."student_id",
    "student_records"."record_type",
    "count"(*) AS "record_count"
   FROM "public"."student_records"
  WHERE (("student_records"."status")::"text" <> 'inactive'::"text")
  GROUP BY "student_records"."service_id", "student_records"."student_id", "student_records"."record_type";


ALTER TABLE "public"."view_student_records_summary" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_relational" AS
SELECT
    NULL::"uuid" AS "id",
    NULL::"uuid" AS "student_id",
    NULL::"uuid" AS "service_id",
    NULL::"text" AS "created_at",
    NULL::"text" AS "updated_at",
    NULL::"text" AS "strengths_interests",
    NULL::"text" AS "communication",
    NULL::"text" AS "distress_triggers",
    NULL::"text" AS "safe_what",
    NULL::"text" AS "safe_who",
    NULL::"text" AS "peer_relationships",
    NULL::"text" AS "adult_relationships",
    NULL::"text" AS "distress_presentation",
    NULL::"text" AS "happy_presentation",
    NULL::"text" AS "how_to_engage",
    NULL::"text" AS "support_learning",
    NULL::"text" AS "access_arrangements",
    NULL::"text" AS "context",
    NULL::"text" AS "health_needs",
    NULL::"text" AS "known_needs",
    NULL::"text"[] AS "diagnosis",
    NULL::"uuid" AS "created_by",
    NULL::"uuid" AS "updated_by",
    NULL::"text" AS "student_name",
    NULL::"text" AS "base_group",
    NULL::boolean AS "is_context_populated",
    NULL::double precision AS "completion_percentage",
    NULL::"text" AS "created_by_user_name",
    NULL::"text" AS "updated_by_user_name",
    NULL::"text" AS "service_name";


ALTER TABLE "public"."view_student_relational" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_student_tags" WITH ("security_invoker"='on') AS
 SELECT "st"."id",
    "st"."created_at",
    "st"."student_id",
    "st"."service_id",
    "st"."short_tag",
    COALESCE("st"."status", ''::"text") AS "status",
    COALESCE("st"."type", ''::"text") AS "type",
    "st"."created_by",
    "st"."updated_by",
        CASE
            WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN "concat"("s"."preferred_name", ' ', COALESCE("s"."surname", ''::"text"))
            ELSE "concat"(COALESCE("s"."first_name", ''::"text"), ' ', COALESCE("s"."surname", ''::"text"))
        END AS "student_calculated_name",
    COALESCE("serv"."name", ''::"text") AS "service_name",
    COALESCE(("au_created"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "created_by_user_name",
    COALESCE(("au_updated"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "updated_by_user_name"
   FROM (((("public"."student_tags" "st"
     LEFT JOIN "public"."students" "s" ON (("st"."student_id" = "s"."id")))
     LEFT JOIN "public"."services" "serv" ON (("st"."service_id" = "serv"."id")))
     LEFT JOIN "auth"."users" "au_created" ON (("st"."created_by" = "au_created"."id")))
     LEFT JOIN "auth"."users" "au_updated" ON (("st"."updated_by" = "au_updated"."id")));


ALTER TABLE "public"."view_student_tags" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_todays_attendance" WITH ("security_invoker"='on') AS
 WITH "base_groups" AS (
         SELECT DISTINCT ON ("sg_1"."student_id") "sg_1"."student_id",
            "g_1"."id" AS "group_id",
            "g_1"."name" AS "base_group_name"
           FROM ("public"."student_groups" "sg_1"
             JOIN "public"."groups" "g_1" ON (("sg_1"."group_id" = "g_1"."id")))
          WHERE (("g_1"."type" = 'Base'::"text") AND ("sg_1"."status" = 'active'::"text") AND ("g_1"."status" = 'active'::"text"))
        )
 SELECT "vsai"."id",
    "vsai"."student_id",
    "vsai"."service_id",
    "vsai"."term_id",
    "vsai"."week_id",
    "vsai"."date",
    "vsai"."session",
    "vsai"."attendance_code_id",
    "vsai"."comments",
    "vsai"."created_at",
    "vsai"."created_by",
    "vsai"."updated_at",
    "vsai"."updated_by",
    "vsai"."student_calculated_name",
    "vsai"."service_name",
    "vsai"."term_name",
    "vsai"."academic_year_name",
    "vsai"."week_name",
    "vsai"."attendance_code_name",
    "vsai"."attendance_code_description",
    "vsai"."attendance_full_description",
    "vsai"."created_by_user_name",
    "vsai"."updated_by_user_name",
    "vsai"."term_name_year",
    "vsai"."week_name_date_range",
    "bg"."base_group_name",
    "array_agg"(DISTINCT "g"."name") FILTER (WHERE (("sg"."status" = 'active'::"text") AND ("g"."status" = 'active'::"text"))) AS "groups"
   FROM ((("public"."view_student_attendance_info" "vsai"
     LEFT JOIN "public"."student_groups" "sg" ON (("vsai"."student_id" = "sg"."student_id")))
     LEFT JOIN "public"."groups" "g" ON (("sg"."group_id" = "g"."id")))
     LEFT JOIN "base_groups" "bg" ON (("vsai"."student_id" = "bg"."student_id")))
  WHERE ("vsai"."date" = CURRENT_DATE)
  GROUP BY "vsai"."id", "vsai"."student_id", "vsai"."service_id", "vsai"."term_id", "vsai"."week_id", "vsai"."date", "vsai"."session", "vsai"."attendance_code_id", "vsai"."comments", "vsai"."created_at", "vsai"."created_by", "vsai"."updated_at", "vsai"."updated_by", "vsai"."student_calculated_name", "vsai"."service_name", "vsai"."term_name", "vsai"."academic_year_name", "vsai"."week_name", "vsai"."attendance_code_name", "vsai"."attendance_code_description", "vsai"."attendance_full_description", "vsai"."created_by_user_name", "vsai"."updated_by_user_name", "vsai"."term_name_year", "vsai"."week_name_date_range", "bg"."base_group_name";


ALTER TABLE "public"."view_todays_attendance" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_user_roles" WITH ("security_invoker"='on') AS
 SELECT "user_roles"."id",
    "user_roles"."userId",
    "user_roles"."user_application_id",
    "user_roles"."roleId",
    "user_roles"."service_id",
    "lu_roles"."name" AS "role_name"
   FROM ("public"."user_roles"
     JOIN "public"."lu_roles" ON (("lu_roles"."id" = "user_roles"."roleId")));


ALTER TABLE "public"."view_user_roles" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_weekly_student_non_attendance" WITH ("security_invoker"='on') AS
 WITH "student_attendance_status" AS (
         SELECT "sa"."service_id",
            "s"."name" AS "service_name",
            "w"."id" AS "week_id",
            "w"."week_name",
            "w"."week_start",
            "w"."week_end",
            "t"."name" AS "term_name",
            "ay"."name" AS "academic_year_name",
            "sa"."student_id",
            "max"(
                CASE
                    WHEN "lc"."present" THEN 1
                    ELSE 0
                END) AS "has_present_code"
           FROM ((((("public"."student_attendance" "sa"
             JOIN "public"."services" "s" ON (("sa"."service_id" = "s"."id")))
             JOIN "public"."weeks" "w" ON (("sa"."week_id" = "w"."id")))
             JOIN "public"."terms" "t" ON (("w"."term_id" = "t"."id")))
             JOIN "public"."lu_academic_years" "ay" ON (("t"."academic_year_id" = "ay"."id")))
             LEFT JOIN "public"."lu_categories" "lc" ON (("sa"."attendance_code_id" = "lc"."id")))
          WHERE (("sa"."date" >= "w"."week_start") AND ("sa"."date" <= "w"."week_end"))
          GROUP BY "sa"."service_id", "s"."name", "w"."id", "w"."week_name", "w"."week_start", "w"."week_end", "t"."name", "ay"."name", "sa"."student_id"
        )
 SELECT "student_attendance_status"."service_id",
    "student_attendance_status"."service_name",
    "student_attendance_status"."week_id",
    "student_attendance_status"."week_name",
    "student_attendance_status"."week_start",
    "student_attendance_status"."week_end",
    "student_attendance_status"."term_name",
    "student_attendance_status"."academic_year_name",
    "count"(DISTINCT
        CASE
            WHEN ("student_attendance_status"."has_present_code" = 0) THEN "student_attendance_status"."student_id"
            ELSE NULL::"uuid"
        END) AS "student_non_attendance_count"
   FROM "student_attendance_status"
  GROUP BY "student_attendance_status"."service_id", "student_attendance_status"."service_name", "student_attendance_status"."week_id", "student_attendance_status"."week_name", "student_attendance_status"."week_start", "student_attendance_status"."week_end", "student_attendance_status"."term_name", "student_attendance_status"."academic_year_name";


ALTER TABLE "public"."view_weekly_student_non_attendance" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."x_import_actions" (
    "RecordType" "text",
    "Date" "date",
    "Time" time without time zone,
    "Details" "text",
    "Service" "text",
    "Student" "text",
    "Record" "text",
    "Review" "text",
    "Status" "text",
    "AssignedTo" "text",
    "Due Date" "date",
    "FileUpload" "text",
    "CompletedBy" "text",
    "AutoIncrement" bigint,
    "ImportedTime" "text",
    "EntryID" bigint
);


ALTER TABLE "public"."x_import_actions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."x_import_attendance" (
    "StudentTerm" "text",
    "Service" "text",
    "Student" "text",
    "Term" "text",
    "WeekNumber" "text",
    "StartDate" "date",
    "EndDate" "date",
    "SessionCount" bigint,
    "EnteredCount" bigint,
    "TotalOutstanding" "text",
    "Present" bigint,
    "Authorised" "text",
    "C-Authorised" "text",
    "Unauthorised" "text",
    "Admin" "text",
    "Monday" "date",
    "Monday-AM" "text",
    "Monday-PM" "text",
    "Monday-AM-Comment" "text",
    "Monday-PM-Comment" "text",
    "Tuesday" "date",
    "Tuesday-AM" "text",
    "Tuesday-PM" "text",
    "Tuesday-AM-Comment" "text",
    "Tuesday-PM-Comment" "text",
    "Wednesday" "date",
    "Wednesday-AM" "text",
    "Wednesday-PM" "text",
    "Wednesday-AM-Comment" "text",
    "Wednesday-PM-Comment" "text",
    "Thursday" "date",
    "Thursday-AM" "text",
    "Thursday-PM" "text",
    "Thursday-AM-Comment" "text",
    "Thursday-PM-Comment" "text",
    "Friday" "date",
    "Friday-AM" "text",
    "Friday-PM" "text",
    "Friday-AM-Comment" "text",
    "Friday-PM-Comment" "text",
    "AutoIncrement" bigint NOT NULL,
    "DateCreated" timestamp without time zone,
    "DateUpdated" timestamp without time zone,
    "bUpdate" "text",
    "Lookup" "text",
    "ServiceTerm" "text",
    "student_id" "uuid",
    "service_id" "uuid",
    "term_id" "uuid",
    "week_id" "uuid",
    "academic_year_id" "uuid"
);


ALTER TABLE "public"."x_import_attendance" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."x_import_contacts" (
    "ContactName" "text",
    "ContactName : Title" "text",
    "ContactName : First" "text",
    "ContactName : Middle" "text",
    "ContactName : Last" "text",
    "Organisation" "text",
    "JobTitle" "text",
    "Department" "text",
    "Email" "text",
    "Landline" "text",
    "Mobile" "text",
    "Address" "text",
    "Address : Street 1" "text",
    "Address : Street 2" "text",
    "Address : City" "text",
    "Address : State" "text",
    "Address : Zip" "text",
    "Address : Country" "text",
    "Address : Latitude" "text",
    "Address : Longitude" "text",
    "Comments" "text",
    "Status" "text",
    "dContactName" "text",
    "Account" "text",
    "AutoIncrement" bigint,
    "Equation" bigint
);


ALTER TABLE "public"."x_import_contacts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."x_import_needsoutcomes" (
    "Description" "text",
    "Type" "text",
    "EHCP Category" "text",
    "Source" "text",
    "When" "text",
    "Status" "text",
    "Service" "text",
    "Student" "text",
    "DateCreated" "date",
    "DateUpdated" "date",
    "EntryID" bigint,
    "Lookup" "text",
    "supabase_id" "text",
    "ehcp_category_supabase_id" "text",
    "student_supabase_id" "uuid" DEFAULT "gen_random_uuid"(),
    "bUpdate" "text"
);


ALTER TABLE "public"."x_import_needsoutcomes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."x_import_records" (
    "Lookup" "text",
    "Service" "text",
    "Student" "text",
    "RecordType" "text",
    "Record Category" "text",
    "Record SubCategory" "text",
    "CreatedBy" "text",
    "AcademicYear" "text",
    "Date" "text",
    "Details" "text",
    "Status" "text",
    "Auto Increment" bigint NOT NULL,
    "EntryID" bigint,
    "rpi_LinkedRecord" "text",
    "rpi_LinkedRecordEntryID" "text",
    "calc_CountReviews" "text",
    "xx_RiskLevel" "text",
    "ReviewDate" "text",
    "all_OtherStudents" "text",
    "all_OtherStaff" "text",
    "all_OtherPeople" "text",
    "all_dCategory" "text",
    "all_dSubCategory" "text",
    "all_Link1" "text",
    "all_Link2" "text",
    "all_Link3" "text",
    "all_isChildOnChild" "text",
    "all_isESafety" "text",
    "log_isConfidential" "text",
    "log_Hashtag1" "text",
    "log_Hashtag2" "text",
    "log_Hashtag3" "text",
    "log_LocationOfEvidence" "text",
    "sg_inc_isPI" "text",
    "sg_inc_SubjectAbuseHarm" "text",
    "sg_inc_ObjectAbuseHarm" "text",
    "sg_inc_isStudentInjured" "text",
    "sg_inc_StudentInjuredWho" "text",
    "sg_inc_isStaffInjured" "text",
    "sg_inc_StaffInjuredWho" "text",
    "inc_StartTime" "text",
    "inc_Duration" "text",
    "inc_Where" "text",
    "inc_Location" "text",
    "inc_Space" "text",
    "inc_OffsiteLocation" "text",
    "inc_Triggers" "text",
    "inc_Function" "text",
    "inc_OtherFunction" "text",
    "inc_Strategies" "text",
    "inc_OtherStrategies" "text",
    "rpi_isGuidedPI" "text",
    "rpi_isRestrictivePI" "text",
    "rpi_isBlockPI" "text",
    "rpi_CompletedBy" "text",
    "rpi_Where" "text",
    "rpi_EventsPrior" "text",
    "rpi_StepsStrategies" "text",
    "rpi_isReviewRequired" "text",
    "xx_BehaviourLevel" "text",
    "xx_Category" "text",
    "xx_SubCategory" "text",
    "xx_SafeguardingCategory" "text",
    "xx_WhoElseWasThere" "text",
    "xx_MoreInformation" "text",
    "xx_ImportedAnyoneElse" "text",
    "xx_PreviousIncident" "text",
    "xx_Session" "text",
    "xx_Activity" "text",
    "xx_OtherActivity" "text",
    "xx_WasAnythingSaid" "text",
    "xx_WhatWereYouDoing" "text",
    "xx_Physical" "text",
    "xx_OtherPhysical" "text",
    "xx_PhysicalAssault" "text",
    "xx_NonPhysical" "text",
    "xx_OtherNonPhysical" "text",
    "xx_WhatWasSaid" "text",
    "xx_OtherStrategies" "text",
    "xx_WhatWorked" "text",
    "xx_Escalate" "text",
    "xx_SuggestStrategies" "text",
    "xx_Injuries" "text",
    "xx_OtherInformation" "text",
    "xx_ActionTaken" "text",
    "xx_Outcomes" "text",
    "xx_RPITime" "text",
    "xx_RPIDuration" "text",
    "xx_RPIAvoidance" "text",
    "xx_RPIAvoidanceOther" "text",
    "xx_RPIDescribeMeasure" "text",
    "xx_RPILegalJustification" "text",
    "xx_RPIOtherPeople" "text",
    "xx_RPIMeasureEffective" "text",
    "xx_RPIConsequences" "text",
    "xx_RPIInjury" "text",
    "xx_RPIMedicalTreatment" "text",
    "xx_RPIExternalAgencies" "text",
    "PIReferenceID" "text",
    "isPoliceAttendance" "text",
    "PoliceReference" "text",
    "isReferralSSCP" "text",
    "isReferralPolice" "text",
    "isReferralLADO" "text",
    "isReferralSocialWorker" "text",
    "calc_ReviewDate" "text",
    "calc_CountActions" "text",
    "calc_RiskScore" "text",
    "Timestamp" "text",
    "LastUpdated" "text",
    "LastUpdatedBy" "text",
    "actions_all_isRPIReviewRequired" "text",
    "actions_all_isStaffFeedback" "text",
    "actions_sg_EscalationAssessment" "text",
    "actions_sg_OverallAssessmentRisk" "text",
    "actions_sg_Frequency" "text",
    "bUpdate" bigint,
    "calc_CountNotifications" "text",
    "calc_CountRisks" "text",
    "calc_CountInterventions" "text",
    "object_info" "text",
    "antecedent_category" "text",
    "antecedent_sub_category" "text",
    "antecedent_more" "text",
    "trigger_category" "text",
    "trigger_more" "text",
    "need_category" "text",
    "need_sub_category" "text",
    "need_more" "text",
    "function_category" "text",
    "function_more" "text",
    "emergent_behaviours" "text",
    "emergent_behaviours_more" "text",
    "primary_area_of_need" "text",
    "is_disruption" "text",
    "disruption_category" "text",
    "disruption_more" "text",
    "is_harm_caused" "text",
    "new_category" "text",
    "new_sub_category" "text",
    "Admission" "text",
    "all_StudentRole" "text",
    "all_OtherStudentsNEW" "text",
    "all_OtherStaffNEW" "text",
    "rpi_CompletedByNEW" "text",
    "all_isConfirm" "text",
    "all_isBullying" "text",
    "all_ObjectRoleCategoryNEW" "text",
    "rpi_isCompletedbyUser" "text",
    "sg_RiskLevelNEW" "text",
    "inc_StartTimeNEW" "text",
    "inc_DurationNEW" "text",
    "inc_FunctionCategoryNEW" "text",
    "inc_EmergentBehaviourCategoryNEW" "text",
    "inc_StrategiesCategoryNEW" "text",
    "inc_AntecedentCategoryNEW" "text",
    "inc_AntecedentSubCategoryNEW" "text",
    "inc_TriggerCategoryNEW" "text",
    "inc_NeedCategoryNEW" "text",
    "inc_NeedSubCategoryNEW" "text",
    "inc_PrimaryNeedCategoryNEW" "text",
    "inc_DisruptionCategoryNEW" "text",
    "inc_StrategyMoreInfo" "text",
    "inc_WhereCategoryNEW" "text",
    "inc_WhereSubCategoryNEW" "text",
    "sg_inc_StudentInjuredNEW" "text",
    "sg_inc_StaffInjuredNEW" "text",
    "all_RecordTypeCategoryNEW" "text",
    "sg_inc_RiskLocationCategoryNEW" "text",
    "inc_RiskLevelNEW" "text",
    "inc_RiskHarmTypeCategoryNEW" "text",
    "sg_inc_pi_RecordReadBy" "text",
    "student_id" "uuid",
    "service_id" "uuid",
    "record_category_id" "uuid",
    "record_subcategory_id" "uuid"
);


ALTER TABLE "public"."x_import_records" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."x_import_records_reviews" (
    "Date" "text",
    "Category" "text",
    "Details" "text",
    "ChangeBSP" "text",
    "ChangeRA" "text",
    "Status" "text",
    "Service" "text",
    "Student" "text",
    "Record" "text",
    "CompletedBy" "text",
    "AutoIncrement" bigint,
    "EntryID" bigint,
    "InjuriesChild" "text",
    "InjuriesStaff" "text",
    "BodyMap" "text",
    "StudentDebrief" "text",
    "Reflection" "text",
    "Link" "text"
);


ALTER TABLE "public"."x_import_records_reviews" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."x_import_student_contacts" (
    "Student" "text",
    "Service" "text",
    "Contact" "text",
    "Relationship" "text",
    "EmergencyContact" "text",
    "LivesWithThisContact" "text",
    "ParentalResponsibility" "text",
    "External ID" "text",
    "CreatedBy" "text",
    "AutoIncrement" bigint,
    "Equation" bigint,
    "CreatedDate" "text",
    "UpdatedDate" "text",
    "student_id" "uuid",
    "service_id" "uuid",
    "contact_id" "uuid"
);


ALTER TABLE "public"."x_import_student_contacts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."x_import_user_services" (
    "email" "text",
    "service_name" "text",
    "service_id" "uuid",
    "user_id" "uuid",
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


ALTER TABLE "public"."x_import_user_services" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."x_import_users" (
    "email_address" "text" NOT NULL,
    "name" "text",
    "service_id" "uuid",
    "role_id" "uuid",
    "user_id" "uuid"
);


ALTER TABLE "public"."x_import_users" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."x_import_weeks" (
    "Term" "text",
    "Year" "text",
    "WeekNumber" "text",
    "StartDate" "text",
    "EndDate" "text",
    "lu_term_id" "uuid"
);


ALTER TABLE "public"."x_import_weeks" OWNER TO "postgres";


ALTER TABLE ONLY "public"."error_log" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."error_log_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."student_records" ALTER COLUMN "auto_increment" SET DEFAULT "nextval"('"public"."student_records_auto_increment_seq"'::"regclass");



ALTER TABLE ONLY "public"."lu_academic_years"
    ADD CONSTRAINT "academic_years_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."accounts"
    ADD CONSTRAINT "accounts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."actions"
    ADD CONSTRAINT "actions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lu_applications"
    ADD CONSTRAINT "applications_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."lu_applications"
    ADD CONSTRAINT "applications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."audit_log"
    ADD CONSTRAINT "audit_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."confidential_access"
    ADD CONSTRAINT "confidential_access_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."contacts"
    ADD CONSTRAINT "contacts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."error_log"
    ADD CONSTRAINT "error_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."event_follow_ups"
    ADD CONSTRAINT "event_follow_ups_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."event_follow_ups"
    ADD CONSTRAINT "event_follow_ups_template_id_follow_up_order_key" UNIQUE ("template_id", "follow_up_order");



ALTER TABLE ONLY "public"."event_templates"
    ADD CONSTRAINT "event_templates_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."globals"
    ADD CONSTRAINT "globals_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."groups"
    ADD CONSTRAINT "groups_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."links"
    ADD CONSTRAINT "links_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lu_categories"
    ADD CONSTRAINT "lu_categories_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lu_counties"
    ADD CONSTRAINT "lu_counties_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lu_diagnosis"
    ADD CONSTRAINT "lu_diagnosis_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lu_group_types"
    ADD CONSTRAINT "lu_group_types_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lu_record_categories"
    ADD CONSTRAINT "lu_record_categories_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lu_record_subcategories"
    ADD CONSTRAINT "lu_record_subcategories_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lu_terms"
    ADD CONSTRAINT "lu_terms_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."notification_distribution"
    ADD CONSTRAINT "notification_distribution_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."notification_header"
    ADD CONSTRAINT "notification_header_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."organisations"
    ADD CONSTRAINT "organizations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."reports"
    ADD CONSTRAINT "reports_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lu_roles"
    ADD CONSTRAINT "roles_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."lu_roles"
    ADD CONSTRAINT "roles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."services"
    ADD CONSTRAINT "services_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."services"
    ADD CONSTRAINT "services_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_admissions"
    ADD CONSTRAINT "student_admissions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_attendance"
    ADD CONSTRAINT "student_attendance_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_contacts"
    ADD CONSTRAINT "student_contacts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_events"
    ADD CONSTRAINT "student_events_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_groups"
    ADD CONSTRAINT "student_groups_group_id_student_id_key" UNIQUE ("group_id", "student_id");



ALTER TABLE ONLY "public"."student_groups"
    ADD CONSTRAINT "student_groups_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_needsoutcomes"
    ADD CONSTRAINT "student_needsoutcomes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_records_interventions"
    ADD CONSTRAINT "student_records_interventions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_records_needs"
    ADD CONSTRAINT "student_records_needs_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_records"
    ADD CONSTRAINT "student_records_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_records_reviews"
    ADD CONSTRAINT "student_records_reviews_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_records_staff"
    ADD CONSTRAINT "student_records_staff_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_records_students"
    ADD CONSTRAINT "student_records_students_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_relational"
    ADD CONSTRAINT "student_relational_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_relational"
    ADD CONSTRAINT "student_relational_student_id_key" UNIQUE ("student_id");



ALTER TABLE ONLY "public"."student_tags"
    ADD CONSTRAINT "student_tags_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."students"
    ADD CONSTRAINT "students_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."terms"
    ADD CONSTRAINT "terms_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."terms"
    ADD CONSTRAINT "terms_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."terms"
    ADD CONSTRAINT "unique_academic_year_term" UNIQUE ("academic_year_id", "lu_term_id");



ALTER TABLE ONLY "public"."student_records_needs"
    ADD CONSTRAINT "unique_record_need" UNIQUE ("student_record_id", "student_needoutcome_id");



ALTER TABLE ONLY "public"."student_records_staff"
    ADD CONSTRAINT "unique_record_staff" UNIQUE ("student_record_id", "staff_id");



ALTER TABLE ONLY "public"."student_records_students"
    ADD CONSTRAINT "unique_record_student" UNIQUE ("student_record_id", "student_id");



ALTER TABLE ONLY "public"."student_attendance"
    ADD CONSTRAINT "unique_student_date_session" UNIQUE ("student_id", "date", "session");



ALTER TABLE ONLY "public"."weeks"
    ADD CONSTRAINT "unique_term_week" UNIQUE ("term_id", "week_number");



ALTER TABLE ONLY "public"."user_applications"
    ADD CONSTRAINT "user_applications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_applications"
    ADD CONSTRAINT "user_applications_user_id_application_id_key" UNIQUE ("user_id", "application_id");



ALTER TABLE ONLY "public"."user_groups"
    ADD CONSTRAINT "user_groups_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_user_application_id_role_id_key" UNIQUE ("user_application_id", "roleId");



ALTER TABLE ONLY "public"."user_services"
    ADD CONSTRAINT "user_services_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_services"
    ADD CONSTRAINT "user_services_user_id_service_id_key" UNIQUE ("user_id", "service_id");



ALTER TABLE ONLY "public"."weeks"
    ADD CONSTRAINT "weeks_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."x_import_attendance"
    ADD CONSTRAINT "x_import_attendance_pkey" PRIMARY KEY ("AutoIncrement");



ALTER TABLE ONLY "public"."x_import_records"
    ADD CONSTRAINT "x_import_records_pkey" PRIMARY KEY ("Auto Increment");



ALTER TABLE ONLY "public"."x_import_user_services"
    ADD CONSTRAINT "x_import_user_services_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."x_import_users"
    ADD CONSTRAINT "x_import_users_pkey" PRIMARY KEY ("email_address");



CREATE INDEX "idx_audit_log_table_record" ON "public"."audit_log" USING "btree" ("table_name", "record_id");



CREATE INDEX "idx_confidential_access_granted_by" ON "public"."confidential_access" USING "btree" ("granted_by");



CREATE INDEX "idx_confidential_access_revoked_by" ON "public"."confidential_access" USING "btree" ("revoked_by");



CREATE INDEX "idx_confidential_access_user_record" ON "public"."confidential_access" USING "btree" ("user_id", "student_record_id");



CREATE INDEX "idx_contacts_organisation_id" ON "public"."contacts" USING "btree" ("organisation_id");



CREATE INDEX "idx_event_follow_ups_template_id" ON "public"."event_follow_ups" USING "btree" ("template_id");



CREATE INDEX "idx_event_templates_category_id" ON "public"."event_templates" USING "btree" ("category_id");



CREATE INDEX "idx_groups_service_id" ON "public"."groups" USING "btree" ("service_id");



CREATE INDEX "idx_groups_status" ON "public"."groups" USING "btree" ("status");



CREATE INDEX "idx_groups_type" ON "public"."groups" USING "btree" ("type");



CREATE INDEX "idx_groups_type_status" ON "public"."groups" USING "btree" ("type", "status");



CREATE INDEX "idx_organizations_is_local_authority" ON "public"."organisations" USING "btree" ("is_local_authority");



CREATE INDEX "idx_organizations_name" ON "public"."organisations" USING "btree" ("organisation_name");



CREATE INDEX "idx_student_admissions_dob" ON "public"."student_admissions" USING "btree" ("dob");



CREATE INDEX "idx_student_admissions_service_id" ON "public"."student_admissions" USING "btree" ("service_id");



CREATE INDEX "idx_student_admissions_status" ON "public"."student_admissions" USING "btree" ("status");



CREATE INDEX "idx_student_admissions_status_student_service" ON "public"."student_admissions" USING "btree" ("status", "student_id", "service_id");



CREATE INDEX "idx_student_admissions_student_id" ON "public"."student_admissions" USING "btree" ("student_id");



CREATE INDEX "idx_student_admissions_student_service" ON "public"."student_admissions" USING "btree" ("student_id", "service_id");



CREATE INDEX "idx_student_admissions_student_service_status" ON "public"."student_admissions" USING "btree" ("student_id", "service_id", "status");



CREATE UNIQUE INDEX "idx_student_admissions_unique_current" ON "public"."student_admissions" USING "btree" ("student_id") WHERE ("is_current" = true);



CREATE UNIQUE INDEX "idx_student_admissions_unique_student_service" ON "public"."student_admissions" USING "btree" ("student_id", "service_id");



CREATE INDEX "idx_student_attendance_date" ON "public"."student_attendance" USING "btree" ("date");



CREATE INDEX "idx_student_attendance_service" ON "public"."student_attendance" USING "btree" ("service_id");



CREATE INDEX "idx_student_attendance_student_date" ON "public"."student_attendance" USING "btree" ("student_id", "date");



CREATE INDEX "idx_student_contacts_contact_id" ON "public"."student_contacts" USING "btree" ("contact_id");



CREATE INDEX "idx_student_contacts_service_id" ON "public"."student_contacts" USING "btree" ("service_id");



CREATE INDEX "idx_student_contacts_student_id" ON "public"."student_contacts" USING "btree" ("student_id");



CREATE INDEX "idx_student_events_parent_event_id" ON "public"."student_events" USING "btree" ("parent_event_id");



CREATE INDEX "idx_student_events_service_id" ON "public"."student_events" USING "btree" ("service_id");



CREATE INDEX "idx_student_events_student_id" ON "public"."student_events" USING "btree" ("student_id");



CREATE INDEX "idx_student_events_template_id" ON "public"."student_events" USING "btree" ("template_id");



CREATE INDEX "idx_student_groups_active" ON "public"."student_groups" USING "btree" ("student_id", "group_id") WHERE ("status" = 'active'::"text");



CREATE INDEX "idx_student_groups_group_id" ON "public"."student_groups" USING "btree" ("group_id");



CREATE INDEX "idx_student_groups_status" ON "public"."student_groups" USING "btree" ("status");



CREATE INDEX "idx_student_groups_student_group_status" ON "public"."student_groups" USING "btree" ("student_id", "group_id", "status");



CREATE INDEX "idx_student_groups_student_id" ON "public"."student_groups" USING "btree" ("student_id");



CREATE INDEX "idx_student_needsoutcomes_source" ON "public"."student_needsoutcomes" USING "btree" ("source");



CREATE INDEX "idx_student_needsoutcomes_status" ON "public"."student_needsoutcomes" USING "btree" ("status");



CREATE INDEX "idx_student_needsoutcomes_student_id" ON "public"."student_needsoutcomes" USING "btree" ("student_id");



CREATE INDEX "idx_student_needsoutcomes_student_type_source_status" ON "public"."student_needsoutcomes" USING "btree" ("student_id", "type", "source", "status");



CREATE INDEX "idx_student_needsoutcomes_type" ON "public"."student_needsoutcomes" USING "btree" ("type");



CREATE INDEX "idx_student_records_academic_year_id" ON "public"."student_records" USING "btree" ("academic_year_id");



CREATE INDEX "idx_student_records_incident_data" ON "public"."student_records" USING "gin" ("incident_data");



CREATE INDEX "idx_student_records_legacy_data" ON "public"."student_records" USING "gin" ("legacy_data");



CREATE INDEX "idx_student_records_needs_needoutcome_id" ON "public"."student_records_needs" USING "btree" ("student_needoutcome_id");



CREATE INDEX "idx_student_records_needs_record_id" ON "public"."student_records_needs" USING "btree" ("student_record_id");



CREATE INDEX "idx_student_records_pi_data" ON "public"."student_records" USING "gin" ("pi_data");



CREATE INDEX "idx_student_records_record_date" ON "public"."student_records" USING "btree" ("record_date");



CREATE INDEX "idx_student_records_record_type" ON "public"."student_records" USING "btree" ("record_type");



CREATE INDEX "idx_student_records_safeguarding_data" ON "public"."student_records" USING "gin" ("safeguarding_data");



CREATE INDEX "idx_student_records_staff_record_id" ON "public"."student_records_staff" USING "btree" ("student_record_id");



CREATE INDEX "idx_student_records_staff_staff_id" ON "public"."student_records_staff" USING "btree" ("staff_id");



CREATE INDEX "idx_student_records_student_id" ON "public"."student_records" USING "btree" ("student_id");



CREATE INDEX "idx_student_records_student_service_date" ON "public"."student_records" USING "btree" ("student_id", "service_id", "date");



CREATE INDEX "idx_student_records_students_record_id" ON "public"."student_records_students" USING "btree" ("student_record_id");



CREATE INDEX "idx_student_records_students_student_id" ON "public"."student_records_students" USING "btree" ("student_id");



CREATE INDEX "idx_student_records_term_id" ON "public"."student_records" USING "btree" ("term_id");



CREATE INDEX "idx_student_relational_service_id" ON "public"."student_relational" USING "btree" ("service_id");



CREATE INDEX "idx_student_relational_student_id" ON "public"."student_relational" USING "btree" ("student_id");



CREATE INDEX "idx_student_tags_service_id" ON "public"."student_tags" USING "btree" ("service_id");



CREATE INDEX "idx_student_tags_status" ON "public"."student_tags" USING "btree" ("status");



CREATE INDEX "idx_student_tags_student_id" ON "public"."student_tags" USING "btree" ("student_id");



CREATE INDEX "idx_student_tags_student_service_status" ON "public"."student_tags" USING "btree" ("student_id", "service_id", "status");



CREATE INDEX "idx_students_id_service_id" ON "public"."students" USING "btree" ("id", "service_id");



CREATE INDEX "idx_students_name_service" ON "public"."students" USING "btree" ((((
CASE
    WHEN ("preferred_name" <> ''::"text") THEN "preferred_name"
    ELSE "first_name"
END || ' '::"text") || "surname")), "service_id");



CREATE INDEX "idx_students_service_id" ON "public"."students" USING "btree" ("service_id");



CREATE UNIQUE INDEX "idx_students_unique_name_service" ON "public"."students" USING "btree" ("service_id", "public"."normalize_student_name"("first_name"), "public"."normalize_student_name"("surname")) WHERE ("middle_name" IS NULL);



CREATE UNIQUE INDEX "idx_students_unique_name_service_with_middle" ON "public"."students" USING "btree" ("service_id", "public"."normalize_student_name"("first_name"), "public"."normalize_student_name"("middle_name"), "public"."normalize_student_name"("surname")) WHERE ("middle_name" IS NOT NULL);



CREATE INDEX "idx_user_groups_group_id" ON "public"."user_groups" USING "btree" ("group_id");



CREATE INDEX "idx_user_groups_group_role_status" ON "public"."user_groups" USING "btree" ("group_id", "role", "status");



CREATE INDEX "idx_user_groups_role" ON "public"."user_groups" USING "btree" ("role");



CREATE INDEX "idx_user_groups_status" ON "public"."user_groups" USING "btree" ("status");



CREATE INDEX "idx_user_groups_user_id" ON "public"."user_groups" USING "btree" ("user_id");



CREATE INDEX "idx_user_roles_user_id" ON "public"."user_roles" USING "btree" ("userId");



CREATE OR REPLACE VIEW "public"."view_student_relational" WITH ("security_invoker"='on') AS
 WITH "base_groups" AS (
         SELECT DISTINCT ON ("sg"."student_id") "sg"."student_id",
            "g"."id" AS "group_id",
            "g"."name"
           FROM ("public"."student_groups" "sg"
             JOIN "public"."groups" "g" ON (("sg"."group_id" = "g"."id")))
          WHERE (("g"."type" = 'Base'::"text") AND ("sg"."status" = 'active'::"text") AND ("g"."status" = 'active'::"text"))
          ORDER BY "sg"."student_id", "sg"."created_at" DESC
        )
 SELECT "sr"."id",
    "sr"."student_id",
    "sr"."service_id",
    "to_char"("sr"."created_at", 'DD/MM/YYYY HH24:MI:SS'::"text") AS "created_at",
    "to_char"("sr"."updated_at", 'DD/MM/YYYY HH24:MI:SS'::"text") AS "updated_at",
    COALESCE("sr"."strengths_interests", ''::"text") AS "strengths_interests",
    COALESCE("sr"."communication", ''::"text") AS "communication",
    COALESCE("sr"."distress_triggers", ''::"text") AS "distress_triggers",
    COALESCE("sr"."safe_what", ''::"text") AS "safe_what",
    COALESCE("sr"."safe_who", ''::"text") AS "safe_who",
    COALESCE("sr"."peer_relationships", ''::"text") AS "peer_relationships",
    COALESCE("sr"."adult_relationships", ''::"text") AS "adult_relationships",
    COALESCE("sr"."distress_presentation", ''::"text") AS "distress_presentation",
    COALESCE("sr"."happy_presentation", ''::"text") AS "happy_presentation",
    COALESCE("sr"."how_to_engage", ''::"text") AS "how_to_engage",
    COALESCE("sr"."support_learning", ''::"text") AS "support_learning",
    COALESCE("sr"."access_arrangements", ''::"text") AS "access_arrangements",
    COALESCE("sr"."context", ''::"text") AS "context",
    COALESCE("sr"."health_needs", ''::"text") AS "health_needs",
    COALESCE("sr"."known_needs", ''::"text") AS "known_needs",
    "sr"."diagnosis",
    "sr"."created_by",
    "sr"."updated_by",
        CASE
            WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN ((COALESCE("s"."preferred_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
            ELSE ((COALESCE("s"."first_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
        END AS "student_name",
    COALESCE("bg"."name", ''::"text") AS "base_group",
    ("sr"."context" IS NOT NULL) AS "is_context_populated",
    (((((((((((((((((
        CASE
            WHEN (COALESCE("sr"."strengths_interests", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END +
        CASE
            WHEN (COALESCE("sr"."communication", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."distress_triggers", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."safe_what", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."safe_who", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."peer_relationships", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."adult_relationships", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."distress_presentation", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."happy_presentation", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."how_to_engage", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."support_learning", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."access_arrangements", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."context", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."health_needs", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END) +
        CASE
            WHEN (COALESCE("sr"."known_needs", ''::"text") <> ''::"text") THEN 1
            ELSE 0
        END))::double precision / (15)::double precision) * (100)::double precision) AS "completion_percentage",
    COALESCE(("au_created"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "created_by_user_name",
    COALESCE(("au_updated"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "updated_by_user_name",
    COALESCE("serv"."name", ''::"text") AS "service_name"
   FROM ((((("public"."student_relational" "sr"
     JOIN "public"."students" "s" ON (("sr"."student_id" = "s"."id")))
     LEFT JOIN "base_groups" "bg" ON (("sr"."student_id" = "bg"."student_id")))
     LEFT JOIN "auth"."users" "au_created" ON (("sr"."created_by" = "au_created"."id")))
     LEFT JOIN "auth"."users" "au_updated" ON (("sr"."updated_by" = "au_updated"."id")))
     LEFT JOIN "public"."services" "serv" ON (("sr"."service_id" = "serv"."id")))
  GROUP BY "sr"."id", "sr"."student_id", "sr"."service_id", "sr"."created_at", "sr"."updated_at", "sr"."strengths_interests", "sr"."communication", "sr"."distress_triggers", "sr"."safe_what", "sr"."safe_who", "sr"."peer_relationships", "sr"."adult_relationships", "sr"."distress_presentation", "sr"."happy_presentation", "sr"."how_to_engage", "sr"."support_learning", "sr"."access_arrangements", "sr"."context", "sr"."health_needs", "sr"."known_needs", "sr"."created_by", "sr"."updated_by", "s"."preferred_name", "s"."first_name", "s"."surname", "bg"."name", "au_created"."raw_user_meta_data", "au_updated"."raw_user_meta_data", "serv"."name";



CREATE OR REPLACE VIEW "public"."view_student_info" WITH ("security_invoker"='on') AS
 WITH RECURSIVE "base_groups" AS (
         SELECT DISTINCT ON ("sg_1"."student_id") "sg_1"."student_id",
            "g_1"."id" AS "group_id",
            "g_1"."name"
           FROM ("public"."student_groups" "sg_1"
             JOIN "public"."groups" "g_1" ON (("sg_1"."group_id" = "g_1"."id")))
          WHERE (("g_1"."type" = 'Base'::"text") AND ("sg_1"."status" = 'active'::"text") AND ("g_1"."status" = 'active'::"text"))
        ), "group_teachers" AS (
         SELECT "ug"."group_id",
            "un"."full_name"
           FROM ("public"."user_groups" "ug"
             JOIN "public"."view_user_names" "un" ON (("ug"."user_id" = "un"."id")))
          WHERE (("ug"."role" = 'Teacher'::"text") AND ("ug"."status" = 'active'::"text"))
        ), "group_ccs" AS (
         SELECT "ug"."group_id",
            "un"."full_name"
           FROM ("public"."user_groups" "ug"
             JOIN "public"."view_user_names" "un" ON (("ug"."user_id" = "un"."id")))
          WHERE (("ug"."role" = 'CC'::"text") AND ("ug"."status" = 'active'::"text"))
        ), "group_rsls" AS (
         SELECT "ug"."group_id",
            "un"."full_name"
           FROM ("public"."user_groups" "ug"
             JOIN "public"."view_user_names" "un" ON (("ug"."user_id" = "un"."id")))
          WHERE (("ug"."role" = 'RSL'::"text") AND ("ug"."status" = 'active'::"text"))
        ), "student_counts" AS (
         SELECT "s_1"."id" AS "student_id",
            "count"(DISTINCT "sr"."id") AS "student_relational_count",
            "count"(DISTINCT "sa_1"."id") AS "student_admissions_count",
            "sum"(
                CASE
                    WHEN (("sno"."type" = 'Need'::"text") AND ("sno"."source" = 'SB Assessed'::"text") AND ("sno"."status" = 'active'::"text")) THEN 1
                    ELSE 0
                END) AS "student_sb_needs_count",
            "sum"(
                CASE
                    WHEN (("sno"."type" = 'Need'::"text") AND ("sno"."source" = 'EHCP'::"text") AND ("sno"."status" = 'active'::"text")) THEN 1
                    ELSE 0
                END) AS "student_ehcp_needs_count"
           FROM ((("public"."students" "s_1"
             LEFT JOIN "public"."student_relational" "sr" ON (("s_1"."id" = "sr"."student_id")))
             LEFT JOIN "public"."student_admissions" "sa_1" ON ((("s_1"."id" = "sa_1"."student_id") AND ("sa_1"."is_current" = true))))
             LEFT JOIN "public"."student_needsoutcomes" "sno" ON (("s_1"."id" = "sno"."student_id")))
          GROUP BY "s_1"."id"
        ), "emergency_contacts" AS (
         SELECT "sc_1"."student_id",
            "jsonb_agg"("jsonb_build_object"('id', "c"."id", 'first_name', "c"."first_name", 'last_name', "c"."last_name", 'relationship', "sc_1"."relationship", 'email', "c"."email", 'landline', "c"."landline", 'mobile', "c"."mobile", 'job_title', "c"."job_title", 'department', "c"."department", 'organisation_id', "c"."organisation_id", 'parental_responsibility', "sc_1"."parental_responsibility", 'lives_with_this_contact', "sc_1"."lives_with_this_contact")) AS "emergency_contacts"
           FROM ("public"."student_contacts" "sc_1"
             JOIN "public"."contacts" "c" ON (("sc_1"."contact_id" = "c"."id")))
          WHERE ("sc_1"."emergency_contact" = true)
          GROUP BY "sc_1"."student_id"
        )
 SELECT "s"."id" AS "student_id",
    "s"."color_code" AS "colour_code",
    COALESCE("s"."name", ''::"text") AS "name",
    COALESCE("s"."first_name", ''::"text") AS "first_name",
    COALESCE("s"."middle_name", ''::"text") AS "middle_name",
    COALESCE("s"."surname", ''::"text") AS "surname",
    COALESCE(TRIM(BOTH FROM "concat_ws"(' '::"text", "s"."first_name", NULLIF("s"."middle_name", ''::"text"), "s"."surname")), ''::"text") AS "full_name",
    COALESCE("s"."preferred_name", ''::"text") AS "preferred_name",
        CASE
            WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN "concat"("s"."preferred_name", ' ', "s"."surname")
            ELSE "concat"("s"."first_name", ' ', "s"."surname")
        END AS "calculated_name",
    COALESCE("s"."initials", ''::"text") AS "initials",
    "s"."service_id",
    "serv"."name" AS "service_name",
    "sa"."id" AS "student_admission_id",
    "sa"."status",
    "sa"."start_date",
    "sa"."end_date",
    "sa"."dob",
    "sa"."sg_data_sent",
    "sa"."last_school_attended_id",
    "sa"."local_authority_id",
    COALESCE("sa"."nationality", ''::"text") AS "nationality",
    COALESCE("sa"."ethnicity", ''::"text") AS "ethnicity",
    COALESCE("sa"."religion", ''::"text") AS "religion",
    COALESCE("sa"."current_home_address1", ''::"text") AS "current_home_address1",
    COALESCE("sa"."current_home_address2", ''::"text") AS "current_home_address2",
    COALESCE("sa"."current_home_address3", ''::"text") AS "current_home_address3",
    COALESCE("sa"."current_home_postcode", ''::"text") AS "current_home_postcode",
    COALESCE("sa"."current_home_town", ''::"text") AS "current_home_town",
    COALESCE("sa"."current_home_county", ''::"text") AS "current_home_county",
    COALESCE("sa"."previous_home_address1", ''::"text") AS "previous_home_address1",
    COALESCE("sa"."previous_home_address2", ''::"text") AS "previous_home_address2",
    COALESCE("sa"."previous_home_address3", ''::"text") AS "previous_home_address3",
    COALESCE("sa"."previous_home_town", ''::"text") AS "previous_home_town",
    COALESCE("sa"."previous_home_postcode", ''::"text") AS "previous_home_postcode",
    COALESCE("sa"."previous_home_county", ''::"text") AS "previous_home_county",
    COALESCE("sa"."previous_placement_additional_info", ''::"text") AS "previous_placement_additional_info",
    COALESCE("sa"."uln_uci", ''::"text") AS "uln_uci",
    COALESCE("sa"."destination", ''::"text") AS "destination",
    COALESCE("sa"."sex", ''::"text") AS "sex",
    COALESCE("sa"."gender_identity", ''::"text") AS "gender_identity",
    COALESCE("la_org"."organisation_name", ''::"text") AS "placing_authority",
    COALESCE("school_org"."organisation_name", ''::"text") AS "last_school_attended",
    "array_agg"(DISTINCT "g"."name") FILTER (WHERE (("sg"."status" = 'active'::"text") AND ("g"."status" = 'active'::"text"))) AS "groups",
    "array_agg"(DISTINCT "st"."short_tag") FILTER (WHERE (("st"."short_tag" IS NOT NULL) AND ("st"."status" = 'active'::"text"))) AS "tags",
    (("date_part"('year'::"text", CURRENT_DATE) - "date_part"('year'::"text", "sa"."dob")) - (
        CASE
            WHEN (("date_part"('month'::"text", CURRENT_DATE) < "date_part"('month'::"text", "sa"."dob")) OR (("date_part"('month'::"text", CURRENT_DATE) = "date_part"('month'::"text", "sa"."dob")) AND ("date_part"('day'::"text", CURRENT_DATE) < "date_part"('day'::"text", "sa"."dob")))) THEN 1
            ELSE 0
        END)::double precision) AS "calculated_age",
    "bg"."name" AS "base_group_name",
    COALESCE("gt"."full_name", ''::"text") AS "teacher_name",
    COALESCE("gc"."full_name", ''::"text") AS "cc_name",
    COALESCE("gr"."full_name", ''::"text") AS "rsl_name",
    "sc"."student_relational_count",
    "sc"."student_admissions_count",
    "sc"."student_sb_needs_count",
    "sc"."student_ehcp_needs_count",
    "to_char"("sa"."created_at", 'DD/MM/YYYY HH24:MI:SS'::"text") AS "admission_created_at",
    "to_char"("sa"."updated_at", 'DD/MM/YYYY HH24:MI:SS'::"text") AS "admission_updated_at",
    COALESCE(("au_created"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "admission_created_by_name",
    COALESCE(("au_updated"."raw_user_meta_data" ->> 'full_name'::"text"), ''::"text") AS "admission_updated_by_name",
    COALESCE("ec"."emergency_contacts", '[]'::"jsonb") AS "emergency_contacts"
   FROM ((((((((((((((("public"."students" "s"
     JOIN "public"."services" "serv" ON (("s"."service_id" = "serv"."id")))
     LEFT JOIN "public"."student_admissions" "sa" ON ((("s"."id" = "sa"."student_id") AND ("s"."service_id" = "sa"."service_id") AND ("sa"."is_current" = true))))
     LEFT JOIN "public"."student_groups" "sg" ON (("s"."id" = "sg"."student_id")))
     LEFT JOIN "public"."groups" "g" ON (("sg"."group_id" = "g"."id")))
     LEFT JOIN "public"."student_tags" "st" ON ((("s"."id" = "st"."student_id") AND ("s"."service_id" = "st"."service_id"))))
     LEFT JOIN "base_groups" "bg" ON (("s"."id" = "bg"."student_id")))
     LEFT JOIN "group_teachers" "gt" ON (("bg"."group_id" = "gt"."group_id")))
     LEFT JOIN "group_ccs" "gc" ON (("bg"."group_id" = "gc"."group_id")))
     LEFT JOIN "group_rsls" "gr" ON (("bg"."group_id" = "gr"."group_id")))
     LEFT JOIN "public"."organisations" "la_org" ON (("sa"."local_authority_id" = "la_org"."id")))
     LEFT JOIN "public"."organisations" "school_org" ON (("sa"."last_school_attended_id" = "school_org"."id")))
     LEFT JOIN "auth"."users" "au_created" ON (("sa"."created_by" = "au_created"."id")))
     LEFT JOIN "auth"."users" "au_updated" ON (("sa"."updated_by" = "au_updated"."id")))
     LEFT JOIN "student_counts" "sc" ON (("s"."id" = "sc"."student_id")))
     LEFT JOIN "emergency_contacts" "ec" ON (("s"."id" = "ec"."student_id")))
  GROUP BY "s"."id", "s"."name", "s"."first_name", "s"."middle_name", "s"."surname", "s"."preferred_name", "s"."initials", "s"."service_id", "s"."color_code", "serv"."name", "sa"."id", "sa"."status", "sa"."start_date", "sa"."end_date", "sa"."dob", "sa"."nationality", "sa"."ethnicity", "sa"."religion", "sa"."current_home_address1", "sa"."current_home_address2", "sa"."current_home_address3", "sa"."current_home_town", "sa"."current_home_postcode", "sa"."current_home_county", "sa"."previous_home_address1", "sa"."previous_home_address2", "sa"."previous_home_address3", "sa"."previous_home_town", "sa"."previous_home_postcode", "sa"."previous_home_county", "sa"."previous_placement_additional_info", "sa"."uln_uci", "sa"."destination", "sa"."sg_data_sent", "bg"."name", "gt"."full_name", "gc"."full_name", "gr"."full_name", "sa"."sex", "sa"."gender_identity", "la_org"."organisation_name", "school_org"."organisation_name", "sa"."created_at", "sa"."updated_at", "au_created"."raw_user_meta_data", "au_updated"."raw_user_meta_data", "sc"."student_relational_count", "sc"."student_admissions_count", "sc"."student_sb_needs_count", "sc"."student_ehcp_needs_count", "ec"."emergency_contacts";



CREATE OR REPLACE VIEW "public"."view_student_info_grid" WITH ("security_invoker"='on') AS
 SELECT "s"."id" AS "student_id",
        CASE
            WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN ((COALESCE("s"."preferred_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
            ELSE ((COALESCE("s"."first_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
        END AS "calculated_name",
    COALESCE("s"."initials", ''::"text") AS "initials",
    "array_agg"(DISTINCT "st"."short_tag") FILTER (WHERE (("st"."short_tag" IS NOT NULL) AND ("st"."status" = 'active'::"text"))) AS "tags",
    "sa"."dob" AS "date_of_birth",
    (("date_part"('year'::"text", CURRENT_DATE) - "date_part"('year'::"text", "sa"."dob")) - (
        CASE
            WHEN (("date_part"('month'::"text", CURRENT_DATE) < "date_part"('month'::"text", "sa"."dob")) OR (("date_part"('month'::"text", CURRENT_DATE) = "date_part"('month'::"text", "sa"."dob")) AND ("date_part"('day'::"text", CURRENT_DATE) < "date_part"('day'::"text", "sa"."dob")))) THEN 1
            ELSE 0
        END)::double precision) AS "age",
    "array_agg"(DISTINCT "g"."name") FILTER (WHERE (("sg"."status" = 'active'::"text") AND ("g"."status" = 'active'::"text"))) AS "groups",
    COALESCE("la_org"."organisation_name", ''::"text") AS "placing_authority",
    "sa"."start_date",
    "sa"."end_date",
    "sa"."status",
    "srv"."name" AS "service_name",
    "s"."service_id"
   FROM (((((("public"."students" "s"
     LEFT JOIN "public"."student_admissions" "sa" ON ((("s"."id" = "sa"."student_id") AND ("s"."service_id" = "sa"."service_id") AND ("sa"."is_current" = true))))
     LEFT JOIN "public"."student_groups" "sg" ON (("s"."id" = "sg"."student_id")))
     LEFT JOIN "public"."groups" "g" ON (("sg"."group_id" = "g"."id")))
     LEFT JOIN "public"."student_tags" "st" ON ((("s"."id" = "st"."student_id") AND ("s"."service_id" = "st"."service_id"))))
     LEFT JOIN "public"."organisations" "la_org" ON (("sa"."local_authority_id" = "la_org"."id")))
     JOIN "public"."services" "srv" ON (("s"."service_id" = "srv"."id")))
  GROUP BY "s"."id", "s"."preferred_name", "s"."surname", "s"."first_name", "s"."initials", "sa"."dob", "sa"."start_date", "sa"."end_date", "sa"."status", "srv"."name", "la_org"."organisation_name"
  ORDER BY
        CASE
            WHEN (COALESCE("s"."preferred_name", ''::"text") <> ''::"text") THEN ((COALESCE("s"."preferred_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
            ELSE ((COALESCE("s"."first_name", ''::"text") || ' '::"text") || COALESCE("s"."surname", ''::"text"))
        END;



CREATE OR REPLACE TRIGGER "audit_student_admissions_relational" AFTER UPDATE ON "public"."student_relational" FOR EACH ROW EXECUTE FUNCTION "public"."audit_student_relational"();



CREATE OR REPLACE TRIGGER "audit_student_admissions_trigger" AFTER UPDATE ON "public"."student_admissions" FOR EACH ROW EXECUTE FUNCTION "public"."audit_student_admissions"();



CREATE OR REPLACE TRIGGER "audit_student_records_trigger" AFTER UPDATE ON "public"."student_records" FOR EACH ROW EXECUTE FUNCTION "public"."audit_student_records"();



CREATE OR REPLACE TRIGGER "audit_student_relational_trigger" AFTER UPDATE ON "public"."student_relational" FOR EACH ROW EXECUTE FUNCTION "public"."audit_student_relational"();



CREATE OR REPLACE TRIGGER "audit_students_trigger" AFTER UPDATE ON "public"."students" FOR EACH ROW EXECUTE FUNCTION "public"."audit_students"();



CREATE OR REPLACE TRIGGER "calculate_admission_status_trigger" BEFORE INSERT OR UPDATE ON "public"."student_admissions" FOR EACH ROW EXECUTE FUNCTION "public"."calculate_admission_status"();



CREATE OR REPLACE TRIGGER "check_student_tag_before_upsert" BEFORE INSERT OR UPDATE ON "public"."student_tags" FOR EACH ROW EXECUTE FUNCTION "public"."check_and_upsert_student_tag"();



CREATE OR REPLACE TRIGGER "create_link_records_trigger" AFTER INSERT OR UPDATE ON "public"."student_records" FOR EACH ROW EXECUTE FUNCTION "public"."create_link_records"();



CREATE OR REPLACE TRIGGER "enforce_risk_level_rule" AFTER INSERT OR UPDATE ON "public"."student_records" FOR EACH ROW EXECUTE FUNCTION "public"."check_risk_level"();



CREATE OR REPLACE TRIGGER "handle_empty_dates_trigger" BEFORE INSERT OR UPDATE ON "public"."student_admissions" FOR EACH ROW EXECUTE FUNCTION "public"."handle_empty_dates"();



CREATE OR REPLACE TRIGGER "handle_student_admission_current_flag_trigger" BEFORE INSERT OR UPDATE ON "public"."student_admissions" FOR EACH ROW EXECUTE FUNCTION "public"."handle_student_admission_current_flag"();



CREATE OR REPLACE TRIGGER "populate_student_event_details_trigger" AFTER INSERT ON "public"."student_events" FOR EACH ROW EXECUTE FUNCTION "public"."populate_student_event_details"();



CREATE OR REPLACE TRIGGER "send_notification" AFTER INSERT ON "public"."notification_distribution" FOR EACH ROW EXECUTE FUNCTION "public"."http_request"('https://n8n.quay-tech.co.uk/webhook/cab75308-4666-4be8-bac3-ccff88b933c7', 'POST', '{"Content-Type":"application/json"}', '{}', '1000');



CREATE OR REPLACE TRIGGER "set_all_day_trigger" BEFORE INSERT OR UPDATE ON "public"."student_events" FOR EACH ROW EXECUTE FUNCTION "public"."auto_set_all_day"();



CREATE OR REPLACE TRIGGER "set_lookup" BEFORE INSERT OR UPDATE ON "public"."student_records" FOR EACH ROW EXECUTE FUNCTION "public"."generate_lookup"();

ALTER TABLE "public"."student_records" DISABLE TRIGGER "set_lookup";



CREATE OR REPLACE TRIGGER "set_student_record_lookup" BEFORE INSERT ON "public"."student_records" FOR EACH ROW EXECUTE FUNCTION "public"."generate_student_record_lookup"();



CREATE OR REPLACE TRIGGER "set_student_records_academic_year_and_term_trigger" AFTER INSERT ON "public"."student_records" FOR EACH ROW EXECUTE FUNCTION "public"."set_student_records_academic_year_and_term"();



CREATE OR REPLACE TRIGGER "set_term_and_academic_year" BEFORE INSERT OR UPDATE OF "date" ON "public"."student_records" FOR EACH ROW EXECUTE FUNCTION "public"."determine_term_and_academic_year"();



CREATE OR REPLACE TRIGGER "standardize_student_names_trigger" BEFORE INSERT OR UPDATE ON "public"."students" FOR EACH ROW EXECUTE FUNCTION "public"."standardize_student_names"();



CREATE OR REPLACE TRIGGER "student_color_trigger" BEFORE INSERT ON "public"."students" FOR EACH ROW EXECUTE FUNCTION "public"."set_student_color"();



CREATE OR REPLACE TRIGGER "update_admission_status" BEFORE INSERT OR UPDATE ON "public"."student_admissions" FOR EACH ROW EXECUTE FUNCTION "public"."calculate_admission_status"();



CREATE OR REPLACE TRIGGER "update_contacts_timestamp" BEFORE UPDATE ON "public"."contacts" FOR EACH ROW EXECUTE FUNCTION "public"."update_contacts_timestamp"();



CREATE OR REPLACE TRIGGER "update_event_follow_up_interval_trigger" BEFORE INSERT OR UPDATE ON "public"."event_follow_ups" FOR EACH ROW EXECUTE FUNCTION "public"."update_event_follow_up_interval"();



CREATE OR REPLACE TRIGGER "update_event_template_interval_trigger" BEFORE INSERT OR UPDATE ON "public"."event_templates" FOR EACH ROW EXECUTE FUNCTION "public"."update_event_template_interval"();



CREATE OR REPLACE TRIGGER "update_group_memberships_trigger" AFTER INSERT OR UPDATE ON "public"."groups" FOR EACH ROW EXECUTE FUNCTION "public"."update_group_memberships"();



CREATE OR REPLACE TRIGGER "update_lookup_trigger" BEFORE UPDATE ON "public"."student_records" FOR EACH ROW WHEN ((("old"."record_type")::"text" IS DISTINCT FROM ("new"."record_type")::"text")) EXECUTE FUNCTION "public"."update_lookup_on_change"();



CREATE OR REPLACE TRIGGER "update_student_contacts_timestamp" BEFORE UPDATE ON "public"."student_contacts" FOR EACH ROW EXECUTE FUNCTION "public"."update_student_contacts_timestamp"();



CREATE OR REPLACE TRIGGER "update_student_needsoutcomes_audit_trigger" BEFORE UPDATE ON "public"."student_needsoutcomes" FOR EACH ROW EXECUTE FUNCTION "public"."update_student_needsoutcomes_audit_fields"();



ALTER TABLE ONLY "public"."actions"
    ADD CONSTRAINT "actions_assigned_to_fkey" FOREIGN KEY ("assigned_to") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."actions"
    ADD CONSTRAINT "actions_completed_by_fkey" FOREIGN KEY ("completed_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."actions"
    ADD CONSTRAINT "actions_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."actions"
    ADD CONSTRAINT "actions_event_id_fkey" FOREIGN KEY ("student_event_id") REFERENCES "public"."student_events"("id");



ALTER TABLE ONLY "public"."actions"
    ADD CONSTRAINT "actions_organisation_id_fkey" FOREIGN KEY ("organisation_id") REFERENCES "public"."organisations"("id");



ALTER TABLE ONLY "public"."actions"
    ADD CONSTRAINT "actions_relational_id_fkey" FOREIGN KEY ("student_relational_id") REFERENCES "public"."student_relational"("id");



ALTER TABLE ONLY "public"."actions"
    ADD CONSTRAINT "actions_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."actions"
    ADD CONSTRAINT "actions_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."confidential_access"
    ADD CONSTRAINT "confidential_access_granted_by_fkey" FOREIGN KEY ("granted_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."confidential_access"
    ADD CONSTRAINT "confidential_access_revoked_by_fkey" FOREIGN KEY ("revoked_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."confidential_access"
    ADD CONSTRAINT "confidential_access_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."contacts"
    ADD CONSTRAINT "contacts_organisation_id_fkey" FOREIGN KEY ("organisation_id") REFERENCES "public"."organisations"("id");



ALTER TABLE ONLY "public"."contacts"
    ADD CONSTRAINT "contacts_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."event_follow_ups"
    ADD CONSTRAINT "event_follow_ups_template_id_fkey" FOREIGN KEY ("template_id") REFERENCES "public"."event_templates"("id");



ALTER TABLE ONLY "public"."event_templates"
    ADD CONSTRAINT "event_templates_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "public"."lu_categories"("id");



ALTER TABLE ONLY "public"."student_records"
    ADD CONSTRAINT "fk_academic_year" FOREIGN KEY ("academic_year_id") REFERENCES "public"."lu_academic_years"("id");



ALTER TABLE ONLY "public"."student_records"
    ADD CONSTRAINT "fk_service" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."student_records_staff"
    ADD CONSTRAINT "fk_staff" FOREIGN KEY ("staff_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."student_records"
    ADD CONSTRAINT "fk_student" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."student_records_students"
    ADD CONSTRAINT "fk_student" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."student_records_needs"
    ADD CONSTRAINT "fk_student_needoutcome" FOREIGN KEY ("student_needoutcome_id") REFERENCES "public"."student_needsoutcomes"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."student_records_needs"
    ADD CONSTRAINT "fk_student_record" FOREIGN KEY ("student_record_id") REFERENCES "public"."student_records"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."student_records_staff"
    ADD CONSTRAINT "fk_student_record" FOREIGN KEY ("student_record_id") REFERENCES "public"."student_records"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."student_records_students"
    ADD CONSTRAINT "fk_student_record" FOREIGN KEY ("student_record_id") REFERENCES "public"."student_records"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."student_records"
    ADD CONSTRAINT "fk_updated_by" FOREIGN KEY ("updated_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."globals"
    ADD CONSTRAINT "globals_current_academic_year_fkey" FOREIGN KEY ("current_academic_year") REFERENCES "public"."lu_academic_years"("id");



ALTER TABLE ONLY "public"."globals"
    ADD CONSTRAINT "globals_current_term_fkey" FOREIGN KEY ("current_term") REFERENCES "public"."terms"("id");



ALTER TABLE ONLY "public"."globals"
    ADD CONSTRAINT "globals_current_week_fkey" FOREIGN KEY ("current_week") REFERENCES "public"."weeks"("id");



ALTER TABLE ONLY "public"."groups"
    ADD CONSTRAINT "groups_cc_fkey" FOREIGN KEY ("cc") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."groups"
    ADD CONSTRAINT "groups_rsl_fkey" FOREIGN KEY ("rsl") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."groups"
    ADD CONSTRAINT "groups_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."groups"
    ADD CONSTRAINT "groups_teacher_fkey" FOREIGN KEY ("teacher") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."links"
    ADD CONSTRAINT "links_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."links"
    ADD CONSTRAINT "links_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."lu_record_subcategories"
    ADD CONSTRAINT "lu_record_subcategories_record_category_id_fkey" FOREIGN KEY ("record_category_id") REFERENCES "public"."lu_record_categories"("id");



ALTER TABLE ONLY "public"."notification_distribution"
    ADD CONSTRAINT "notification_distribution_notification_header_id_fkey" FOREIGN KEY ("notification_header_id") REFERENCES "public"."notification_header"("id");



ALTER TABLE ONLY "public"."notification_distribution"
    ADD CONSTRAINT "notification_distribution_recipient_id_fkey" FOREIGN KEY ("recipient_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."notification_header"
    ADD CONSTRAINT "notification_header_sender-id_fkey" FOREIGN KEY ("sender-id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."notification_header"
    ADD CONSTRAINT "notification_header_student_record_id_fkey1" FOREIGN KEY ("student_record_id") REFERENCES "public"."student_records"("id");



ALTER TABLE ONLY "public"."reports"
    ADD CONSTRAINT "reports_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."student_admissions"
    ADD CONSTRAINT "student_admissions_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."student_admissions"
    ADD CONSTRAINT "student_admissions_last_school_attended_id_fkey" FOREIGN KEY ("last_school_attended_id") REFERENCES "public"."organisations"("id");



ALTER TABLE ONLY "public"."student_admissions"
    ADD CONSTRAINT "student_admissions_local_authority_id_fkey" FOREIGN KEY ("local_authority_id") REFERENCES "public"."organisations"("id");



ALTER TABLE ONLY "public"."student_admissions"
    ADD CONSTRAINT "student_admissions_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."student_admissions"
    ADD CONSTRAINT "student_admissions_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."student_attendance"
    ADD CONSTRAINT "student_attendance_attendance_code_id_fkey" FOREIGN KEY ("attendance_code_id") REFERENCES "public"."lu_categories"("id");



ALTER TABLE ONLY "public"."student_attendance"
    ADD CONSTRAINT "student_attendance_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."student_attendance"
    ADD CONSTRAINT "student_attendance_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."student_attendance"
    ADD CONSTRAINT "student_attendance_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."student_attendance"
    ADD CONSTRAINT "student_attendance_term_id_fkey" FOREIGN KEY ("term_id") REFERENCES "public"."terms"("id");



ALTER TABLE ONLY "public"."student_attendance"
    ADD CONSTRAINT "student_attendance_week_id_fkey" FOREIGN KEY ("week_id") REFERENCES "public"."weeks"("id");



ALTER TABLE ONLY "public"."student_contacts"
    ADD CONSTRAINT "student_contacts_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "public"."contacts"("id");



ALTER TABLE ONLY "public"."student_contacts"
    ADD CONSTRAINT "student_contacts_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."student_contacts"
    ADD CONSTRAINT "student_contacts_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."student_contacts"
    ADD CONSTRAINT "student_contacts_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."student_events"
    ADD CONSTRAINT "student_events_parent_event_id_fkey" FOREIGN KEY ("parent_event_id") REFERENCES "public"."student_events"("id");



ALTER TABLE ONLY "public"."student_events"
    ADD CONSTRAINT "student_events_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."student_events"
    ADD CONSTRAINT "student_events_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."student_events"
    ADD CONSTRAINT "student_events_template_id_fkey" FOREIGN KEY ("template_id") REFERENCES "public"."event_templates"("id");



ALTER TABLE ONLY "public"."student_groups"
    ADD CONSTRAINT "student_groups_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id");



ALTER TABLE ONLY "public"."student_groups"
    ADD CONSTRAINT "student_groups_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."student_groups"
    ADD CONSTRAINT "student_groups_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."student_needsoutcomes"
    ADD CONSTRAINT "student_needsoutcomes_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."student_needsoutcomes"
    ADD CONSTRAINT "student_needsoutcomes_ehcp_category_id_fkey" FOREIGN KEY ("ehcp_category_id") REFERENCES "public"."lu_categories"("id");



ALTER TABLE ONLY "public"."student_needsoutcomes"
    ADD CONSTRAINT "student_needsoutcomes_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."student_needsoutcomes"
    ADD CONSTRAINT "student_needsoutcomes_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."student_needsoutcomes"
    ADD CONSTRAINT "student_needsoutcomes_updated_by_fkey" FOREIGN KEY ("updated_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."student_records"
    ADD CONSTRAINT "student_records_contact_id_fkey" FOREIGN KEY ("contact_id") REFERENCES "public"."contacts"("id");



ALTER TABLE ONLY "public"."student_records"
    ADD CONSTRAINT "student_records_contact_id_fkey1" FOREIGN KEY ("contact_id") REFERENCES "public"."contacts"("id");



ALTER TABLE ONLY "public"."student_records"
    ADD CONSTRAINT "student_records_record_category_id_fkey" FOREIGN KEY ("record_category_id") REFERENCES "public"."lu_record_categories"("id") ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;



ALTER TABLE ONLY "public"."student_records"
    ADD CONSTRAINT "student_records_record_subcategory_id_fkey" FOREIGN KEY ("record_subcategory_id") REFERENCES "public"."lu_record_subcategories"("id") ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;



ALTER TABLE ONLY "public"."student_records_reviews"
    ADD CONSTRAINT "student_records_reviews_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."student_records_reviews"
    ADD CONSTRAINT "student_records_reviews_student_record_id_fkey" FOREIGN KEY ("student_record_id") REFERENCES "public"."student_records"("id");



ALTER TABLE ONLY "public"."student_records"
    ADD CONSTRAINT "student_records_term_id_fkey" FOREIGN KEY ("term_id") REFERENCES "public"."terms"("id");



ALTER TABLE ONLY "public"."student_relational"
    ADD CONSTRAINT "student_relational_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."student_relational"
    ADD CONSTRAINT "student_relational_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."student_tags"
    ADD CONSTRAINT "student_tags_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."student_tags"
    ADD CONSTRAINT "student_tags_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."student_tags"
    ADD CONSTRAINT "student_tags_student_id_fkey1" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."students"
    ADD CONSTRAINT "students_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."students"
    ADD CONSTRAINT "students_updated_by_fkey" FOREIGN KEY ("updated_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."terms"
    ADD CONSTRAINT "terms_academic_year_id_fkey" FOREIGN KEY ("academic_year_id") REFERENCES "public"."lu_academic_years"("id");



ALTER TABLE ONLY "public"."terms"
    ADD CONSTRAINT "terms_lu_term_id_fkey" FOREIGN KEY ("lu_term_id") REFERENCES "public"."lu_terms"("id");



ALTER TABLE ONLY "public"."user_applications"
    ADD CONSTRAINT "user_applications_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "public"."lu_applications"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_applications"
    ADD CONSTRAINT "user_applications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_groups"
    ADD CONSTRAINT "user_groups_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id");



ALTER TABLE ONLY "public"."user_groups"
    ADD CONSTRAINT "user_groups_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."user_groups"
    ADD CONSTRAINT "user_groups_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "public"."lu_roles"("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_role_id_fkey" FOREIGN KEY ("roleId") REFERENCES "public"."lu_roles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_user_application_id_fkey" FOREIGN KEY ("user_application_id") REFERENCES "public"."user_applications"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_services"
    ADD CONSTRAINT "user_services_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_services"
    ADD CONSTRAINT "user_services_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."weeks"
    ADD CONSTRAINT "weeks_term_id_fkey" FOREIGN KEY ("term_id") REFERENCES "public"."terms"("id");



ALTER TABLE ONLY "public"."x_import_attendance"
    ADD CONSTRAINT "x_import_attendance_academic_year_id_fkey" FOREIGN KEY ("academic_year_id") REFERENCES "public"."lu_academic_years"("id");



ALTER TABLE ONLY "public"."x_import_attendance"
    ADD CONSTRAINT "x_import_attendance_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."x_import_attendance"
    ADD CONSTRAINT "x_import_attendance_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id");



ALTER TABLE ONLY "public"."x_import_attendance"
    ADD CONSTRAINT "x_import_attendance_term_id_fkey" FOREIGN KEY ("term_id") REFERENCES "public"."terms"("id");



ALTER TABLE ONLY "public"."x_import_attendance"
    ADD CONSTRAINT "x_import_attendance_week_id_fkey" FOREIGN KEY ("week_id") REFERENCES "public"."weeks"("id");



ALTER TABLE ONLY "public"."x_import_users"
    ADD CONSTRAINT "x_import_users_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."lu_roles"("id");



ALTER TABLE ONLY "public"."x_import_users"
    ADD CONSTRAINT "x_import_users_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."services"("id");



ALTER TABLE ONLY "public"."x_import_users"
    ADD CONSTRAINT "x_import_users_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."x_import_weeks"
    ADD CONSTRAINT "x_import_weeks_lu_term_id_fkey" FOREIGN KEY ("lu_term_id") REFERENCES "public"."lu_terms"("id");



CREATE POLICY "All insert" ON "public"."notification_distribution" FOR INSERT WITH CHECK (true);



CREATE POLICY "Allow all insert" ON "public"."notification_header" FOR INSERT WITH CHECK (true);



CREATE POLICY "Allow inserts for IT Team members" ON "public"."services" FOR INSERT WITH CHECK ((("auth"."uid"() IN ( SELECT "user_roles"."userId"
   FROM ("public"."user_roles"
     JOIN "public"."lu_roles" ON (("user_roles"."roleId" = "lu_roles"."id")))
  WHERE ("lu_roles"."name" = 'IT Team'::"text"))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "Allow updates for IT Team members" ON "public"."services" FOR UPDATE USING ((("auth"."uid"() IN ( SELECT "user_roles"."userId"
   FROM ("public"."user_roles"
     JOIN "public"."lu_roles" ON (("user_roles"."roleId" = "lu_roles"."id")))
  WHERE ("lu_roles"."name" = 'IT Team'::"text"))) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK (true);



CREATE POLICY "Authenticated users and postgres can delete" ON "public"."notification_header" FOR DELETE TO "authenticated", "postgres" USING (true);



CREATE POLICY "Authenticated users and postgres can insert" ON "public"."notification_header" FOR INSERT TO "authenticated", "postgres" WITH CHECK (true);



CREATE POLICY "Authenticated users and postgres can select" ON "public"."notification_header" FOR SELECT TO "authenticated", "postgres" USING (true);



CREATE POLICY "Authenticated users and postgres can update" ON "public"."notification_header" FOR UPDATE TO "authenticated", "postgres" USING (true) WITH CHECK (true);



ALTER TABLE "public"."accounts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."actions" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "actions_insert_policy" ON "public"."actions" FOR INSERT WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "actions"."service_id"))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "actions_update_policy" ON "public"."actions" FOR UPDATE USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "actions"."service_id"))) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "actions"."service_id"))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "actions_view_policy" ON "public"."actions" FOR SELECT USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "actions"."service_id"))) OR (CURRENT_USER = 'postgres'::"name")));



ALTER TABLE "public"."audit_log" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "audit_log_auth_all_policy" ON "public"."audit_log" USING ((("auth"."uid"() IS NOT NULL) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IS NOT NULL) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "authenticate_service_policy" ON "public"."student_admissions" TO "authenticated" USING (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"())))) WITH CHECK (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"()))));



CREATE POLICY "authenticate_service_policy" ON "public"."student_attendance" TO "authenticated" USING (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"())))) WITH CHECK (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"()))));



CREATE POLICY "authenticate_service_policy" ON "public"."student_contacts" TO "authenticated" USING (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"())))) WITH CHECK (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"()))));



CREATE POLICY "authenticate_service_policy" ON "public"."student_events" TO "authenticated" USING (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"())))) WITH CHECK (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"()))));



CREATE POLICY "authenticate_service_policy" ON "public"."student_needsoutcomes" TO "authenticated" USING (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"())))) WITH CHECK (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"()))));



CREATE POLICY "authenticate_service_policy" ON "public"."student_relational" TO "authenticated" USING (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"())))) WITH CHECK (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"()))));



CREATE POLICY "authenticate_service_policy" ON "public"."student_tags" TO "authenticated" USING (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"())))) WITH CHECK (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"()))));



CREATE POLICY "authenticate_service_policy" ON "public"."students" TO "authenticated" USING (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"())))) WITH CHECK (("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"()))));



CREATE POLICY "authenticated_full_access_policy" ON "public"."lu_academic_years" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."lu_applications" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."lu_categories" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."lu_counties" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."lu_diagnosis" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."lu_group_types" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."lu_record_categories" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."lu_record_subcategories" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."lu_roles" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."lu_terms" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."x_import_attendance" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."x_import_records" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "authenticated_full_access_policy" ON "public"."x_import_weeks" TO "authenticated" USING (true) WITH CHECK (true);



ALTER TABLE "public"."confidential_access" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "confidential_access_policy" ON "public"."confidential_access" TO "authenticated" USING ((("user_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM ("public"."user_roles" "ur"
     JOIN "public"."lu_roles" "lr" ON (("ur"."roleId" = "lr"."id")))
  WHERE (("ur"."userId" = "auth"."uid"()) AND ("lr"."name" = 'SLT'::"text")))))) WITH CHECK ((("user_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM ("public"."user_roles" "ur"
     JOIN "public"."lu_roles" "lr" ON (("ur"."roleId" = "lr"."id")))
  WHERE (("ur"."userId" = "auth"."uid"()) AND ("lr"."name" = 'SLT'::"text"))))));



ALTER TABLE "public"."contacts" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "contacts_auth_policy" ON "public"."contacts" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "contacts_view_policy" ON "public"."contacts" FOR SELECT TO "authenticated" USING ((("service_id" IS NULL) OR ("service_id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"())))));



ALTER TABLE "public"."error_log" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "error_log_auth_all_policy" ON "public"."error_log" USING ((("auth"."uid"() IS NOT NULL) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IS NOT NULL) OR (CURRENT_USER = 'postgres'::"name")));



ALTER TABLE "public"."event_follow_ups" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "event_follow_ups_all_access" ON "public"."event_follow_ups" TO "postgres" USING (true);



CREATE POLICY "event_follow_ups_insert" ON "public"."event_follow_ups" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "event_follow_ups_update" ON "public"."event_follow_ups" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "event_follow_ups_view" ON "public"."event_follow_ups" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "event_follow_ups_view_policy" ON "public"."event_follow_ups" FOR SELECT TO "authenticated";



ALTER TABLE "public"."event_templates" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "event_templates_all_access" ON "public"."event_templates" TO "postgres" USING (true);



CREATE POLICY "event_templates_insert" ON "public"."event_templates" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "event_templates_update" ON "public"."event_templates" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "event_templates_view" ON "public"."event_templates" FOR SELECT TO "authenticated" USING (true);



ALTER TABLE "public"."globals" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "globals_auth_all_policy" ON "public"."globals" USING ((("auth"."uid"() IS NOT NULL) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IS NOT NULL) OR (CURRENT_USER = 'postgres'::"name")));



ALTER TABLE "public"."groups" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "groups_insert_policy" ON "public"."groups" FOR INSERT WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "groups"."service_id"))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "groups_update_policy" ON "public"."groups" FOR UPDATE USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "groups"."service_id"))) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "groups"."service_id"))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "groups_view_policy" ON "public"."groups" FOR SELECT USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "groups"."service_id"))) OR (CURRENT_USER = 'postgres'::"name")));



ALTER TABLE "public"."links" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "links_insert_policy" ON "public"."links" FOR INSERT WITH CHECK (("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "links"."service_id"))));



CREATE POLICY "links_update_policy" ON "public"."links" FOR UPDATE USING (("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "links"."service_id")))) WITH CHECK (("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "links"."service_id"))));



CREATE POLICY "links_view_policy" ON "public"."links" FOR SELECT USING (("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "links"."service_id"))));



ALTER TABLE "public"."lu_academic_years" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."lu_applications" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."lu_categories" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."lu_counties" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."lu_diagnosis" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."lu_group_types" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."lu_record_categories" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."lu_record_subcategories" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."lu_roles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."lu_terms" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."notification_distribution" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."notification_header" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."organisations" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "organisations_auth_policy" ON "public"."organisations" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_bypass_policy" ON "public"."student_records" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_confidential_access_policy" ON "public"."confidential_access" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."lu_academic_years" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."lu_applications" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."lu_categories" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."lu_counties" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."lu_diagnosis" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."lu_group_types" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."lu_record_categories" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."lu_record_subcategories" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."lu_roles" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."lu_terms" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."student_admissions" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."student_attendance" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."student_contacts" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."student_events" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."student_needsoutcomes" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."student_relational" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."student_tags" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."students" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."user_applications" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."user_groups" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."user_roles" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."user_services" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."x_import_attendance" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."x_import_records" TO "postgres" USING (true) WITH CHECK (true);



CREATE POLICY "postgres_full_access_policy" ON "public"."x_import_weeks" TO "postgres" USING (true) WITH CHECK (true);



ALTER TABLE "public"."reports" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."services" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "services_view_policy" ON "public"."services" FOR SELECT TO "authenticated" USING (("id" IN ( SELECT "user_services"."service_id"
   FROM "public"."user_services"
  WHERE ("user_services"."user_id" = "auth"."uid"()))));



ALTER TABLE "public"."student_admissions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."student_attendance" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."student_contacts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."student_events" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."student_groups" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "student_groups_insert_policy" ON "public"."student_groups" FOR INSERT WITH CHECK ((("auth"."uid"() IS NOT NULL) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_groups_update_policy" ON "public"."student_groups" FOR UPDATE USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "student_groups"."service_id"))) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "student_groups"."service_id"))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_groups_view_policy" ON "public"."student_groups" FOR SELECT USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "student_groups"."service_id"))) OR (CURRENT_USER = 'postgres'::"name")));



ALTER TABLE "public"."student_needsoutcomes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."student_records" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "student_records_insert_policy" ON "public"."student_records" FOR INSERT WITH CHECK (("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "student_records"."service_id"))));



ALTER TABLE "public"."student_records_interventions" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "student_records_interventions_delete_policy" ON "public"."student_records_interventions" FOR DELETE USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_interventions"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_interventions_insert_policy" ON "public"."student_records_interventions" FOR INSERT WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_interventions"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_interventions_update_policy" ON "public"."student_records_interventions" FOR UPDATE USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_interventions"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_interventions"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_interventions_view_policy" ON "public"."student_records_interventions" FOR SELECT USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_interventions"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



ALTER TABLE "public"."student_records_needs" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "student_records_needs_insert_policy" ON "public"."student_records_needs" FOR INSERT WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_needs"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_needs_update_policy" ON "public"."student_records_needs" FOR UPDATE USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_needs"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_needs"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_needs_view_policy" ON "public"."student_records_needs" FOR SELECT USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_needs"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



ALTER TABLE "public"."student_records_reviews" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "student_records_reviews_insert_policy" ON "public"."student_records_reviews" FOR INSERT WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_reviews"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_reviews_update_policy" ON "public"."student_records_reviews" FOR UPDATE USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_reviews"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_reviews"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_reviews_view_policy" ON "public"."student_records_reviews" FOR SELECT USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_reviews"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



ALTER TABLE "public"."student_records_staff" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "student_records_staff_insert_policy" ON "public"."student_records_staff" FOR INSERT WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_staff"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_staff_update_policy" ON "public"."student_records_staff" FOR UPDATE USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_staff"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_staff"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_staff_view_policy" ON "public"."student_records_staff" FOR SELECT USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_staff"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



ALTER TABLE "public"."student_records_students" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "student_records_students_insert_policy" ON "public"."student_records_students" FOR INSERT WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_students"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_students_update_policy" ON "public"."student_records_students" FOR UPDATE USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_students"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_students"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_students_view_policy" ON "public"."student_records_students" FOR SELECT USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = ( SELECT "student_records"."service_id"
           FROM "public"."student_records"
          WHERE ("student_records"."id" = "student_records_students"."student_record_id"))))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "student_records_update_policy" ON "public"."student_records" FOR UPDATE USING (("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "student_records"."service_id")))) WITH CHECK (("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "student_records"."service_id"))));



CREATE POLICY "student_records_view_policy" ON "public"."student_records" FOR SELECT USING (("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "student_records"."service_id"))));



ALTER TABLE "public"."student_relational" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."student_tags" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."students" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."terms" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "terms_view_policy" ON "public"."terms" FOR SELECT TO "authenticated";



ALTER TABLE "public"."user_applications" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_groups" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_groups_insert_policy" ON "public"."user_groups" FOR INSERT WITH CHECK ((("auth"."uid"() IS NOT NULL) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "user_groups_update_policy" ON "public"."user_groups" FOR UPDATE USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "user_groups"."service_id"))) OR (CURRENT_USER = 'postgres'::"name"))) WITH CHECK ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "user_groups"."service_id"))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "user_groups_view_policy" ON "public"."user_groups" FOR SELECT USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "user_groups"."service_id"))) OR (CURRENT_USER = 'postgres'::"name")));



CREATE POLICY "user_own_records_policy" ON "public"."user_applications" TO "authenticated" USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "user_own_records_policy" ON "public"."user_roles" TO "authenticated" USING (("userId" = "auth"."uid"())) WITH CHECK (("userId" = "auth"."uid"()));



CREATE POLICY "user_own_records_policy" ON "public"."user_services" TO "authenticated" USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



ALTER TABLE "public"."user_roles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_services" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "view_select_reports" ON "public"."reports" FOR SELECT USING ((("auth"."uid"() IN ( SELECT "user_services"."user_id"
   FROM "public"."user_services"
  WHERE ("user_services"."service_id" = "reports"."service_id"))) OR (CURRENT_USER = 'postgres'::"name")));



ALTER TABLE "public"."weeks" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_actions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_admissions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_attendance" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_contacts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_needsoutcomes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_records" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_records_reviews" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_student_contacts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_students" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_user_services" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_users" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."x_import_weeks" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


SET SESSION AUTHORIZATION "postgres";
RESET SESSION AUTHORIZATION;






GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";















































































































































































































GRANT ALL ON FUNCTION "public"."audit_student_admissions"() TO "anon";
GRANT ALL ON FUNCTION "public"."audit_student_admissions"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."audit_student_admissions"() TO "service_role";



GRANT ALL ON FUNCTION "public"."audit_student_records"() TO "anon";
GRANT ALL ON FUNCTION "public"."audit_student_records"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."audit_student_records"() TO "service_role";



GRANT ALL ON FUNCTION "public"."audit_student_relational"() TO "anon";
GRANT ALL ON FUNCTION "public"."audit_student_relational"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."audit_student_relational"() TO "service_role";



GRANT ALL ON FUNCTION "public"."audit_students"() TO "anon";
GRANT ALL ON FUNCTION "public"."audit_students"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."audit_students"() TO "service_role";



GRANT ALL ON FUNCTION "public"."auto_set_all_day"() TO "anon";
GRANT ALL ON FUNCTION "public"."auto_set_all_day"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."auto_set_all_day"() TO "service_role";



GRANT ALL ON FUNCTION "public"."calculate_admission_status"() TO "anon";
GRANT ALL ON FUNCTION "public"."calculate_admission_status"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."calculate_admission_status"() TO "service_role";



GRANT ALL ON FUNCTION "public"."calculate_age"("birth_date" "date") TO "anon";
GRANT ALL ON FUNCTION "public"."calculate_age"("birth_date" "date") TO "authenticated";
GRANT ALL ON FUNCTION "public"."calculate_age"("birth_date" "date") TO "service_role";



GRANT ALL ON FUNCTION "public"."calculate_next_active_date"("p_start_date" "date", "p_interval_days" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."calculate_next_active_date"("p_start_date" "date", "p_interval_days" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."calculate_next_active_date"("p_start_date" "date", "p_interval_days" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."check_and_upsert_student_tag"() TO "anon";
GRANT ALL ON FUNCTION "public"."check_and_upsert_student_tag"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_and_upsert_student_tag"() TO "service_role";



GRANT ALL ON FUNCTION "public"."check_is_local_authority"() TO "anon";
GRANT ALL ON FUNCTION "public"."check_is_local_authority"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_is_local_authority"() TO "service_role";



GRANT ALL ON FUNCTION "public"."check_risk_level"() TO "anon";
GRANT ALL ON FUNCTION "public"."check_risk_level"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_risk_level"() TO "service_role";



GRANT ALL ON FUNCTION "public"."create_link_records"() TO "anon";
GRANT ALL ON FUNCTION "public"."create_link_records"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_link_records"() TO "service_role";



GRANT ALL ON FUNCTION "public"."create_student_event_with_followups"("p_student_id" "uuid", "p_service_id" "uuid", "p_template_id" "uuid", "p_start_date" "date") TO "anon";
GRANT ALL ON FUNCTION "public"."create_student_event_with_followups"("p_student_id" "uuid", "p_service_id" "uuid", "p_template_id" "uuid", "p_start_date" "date") TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_student_event_with_followups"("p_student_id" "uuid", "p_service_id" "uuid", "p_template_id" "uuid", "p_start_date" "date") TO "service_role";



GRANT ALL ON FUNCTION "public"."determine_term_and_academic_year"() TO "anon";
GRANT ALL ON FUNCTION "public"."determine_term_and_academic_year"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."determine_term_and_academic_year"() TO "service_role";



GRANT ALL ON FUNCTION "public"."format_interval_display"("p_interval" interval) TO "anon";
GRANT ALL ON FUNCTION "public"."format_interval_display"("p_interval" interval) TO "authenticated";
GRANT ALL ON FUNCTION "public"."format_interval_display"("p_interval" interval) TO "service_role";



GRANT ALL ON FUNCTION "public"."generate_daily_attendance_records"() TO "anon";
GRANT ALL ON FUNCTION "public"."generate_daily_attendance_records"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."generate_daily_attendance_records"() TO "service_role";



GRANT ALL ON FUNCTION "public"."generate_date_series"("start_date" "date", "end_date" "date") TO "anon";
GRANT ALL ON FUNCTION "public"."generate_date_series"("start_date" "date", "end_date" "date") TO "authenticated";
GRANT ALL ON FUNCTION "public"."generate_date_series"("start_date" "date", "end_date" "date") TO "service_role";



GRANT ALL ON FUNCTION "public"."generate_lookup"() TO "anon";
GRANT ALL ON FUNCTION "public"."generate_lookup"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."generate_lookup"() TO "service_role";



GRANT ALL ON FUNCTION "public"."generate_random_color"() TO "anon";
GRANT ALL ON FUNCTION "public"."generate_random_color"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."generate_random_color"() TO "service_role";



GRANT ALL ON FUNCTION "public"."generate_student_record_lookup"() TO "anon";
GRANT ALL ON FUNCTION "public"."generate_student_record_lookup"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."generate_student_record_lookup"() TO "service_role";



GRANT ALL ON FUNCTION "public"."generate_test_attendance_records"("p_service_id" "uuid", "p_term_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."generate_test_attendance_records"("p_service_id" "uuid", "p_term_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."generate_test_attendance_records"("p_service_id" "uuid", "p_term_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."generate_weeks_for_academic_year"("p_academic_year_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."generate_weeks_for_academic_year"("p_academic_year_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."generate_weeks_for_academic_year"("p_academic_year_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_service_attendance_by_code"("p_service_id" "uuid", "p_start_date" "date", "p_end_date" "date") TO "anon";
GRANT ALL ON FUNCTION "public"."get_service_attendance_by_code"("p_service_id" "uuid", "p_start_date" "date", "p_end_date" "date") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_service_attendance_by_code"("p_service_id" "uuid", "p_start_date" "date", "p_end_date" "date") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_service_attendance_stats"("p_service_id" "uuid", "p_start_date" "date", "p_end_date" "date") TO "anon";
GRANT ALL ON FUNCTION "public"."get_service_attendance_stats"("p_service_id" "uuid", "p_start_date" "date", "p_end_date" "date") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_service_attendance_stats"("p_service_id" "uuid", "p_start_date" "date", "p_end_date" "date") TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_empty_dates"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_empty_dates"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_empty_dates"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_student_admission_current_flag"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_student_admission_current_flag"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_student_admission_current_flag"() TO "service_role";



GRANT ALL ON FUNCTION "public"."has_service_access"("service_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."has_service_access"("service_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."has_service_access"("service_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."http_request"() TO "anon";
GRANT ALL ON FUNCTION "public"."http_request"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."http_request"() TO "service_role";



GRANT ALL ON TABLE "public"."x_import_students" TO "anon";
GRANT ALL ON TABLE "public"."x_import_students" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_students" TO "service_role";



GRANT ALL ON FUNCTION "public"."import_student"("import_record" "public"."x_import_students") TO "anon";
GRANT ALL ON FUNCTION "public"."import_student"("import_record" "public"."x_import_students") TO "authenticated";
GRANT ALL ON FUNCTION "public"."import_student"("import_record" "public"."x_import_students") TO "service_role";



GRANT ALL ON FUNCTION "public"."insert_user_service"() TO "anon";
GRANT ALL ON FUNCTION "public"."insert_user_service"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."insert_user_service"() TO "service_role";



GRANT ALL ON FUNCTION "public"."normalize_student_name"("name" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."normalize_student_name"("name" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."normalize_student_name"("name" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."populate_student_event_details"() TO "anon";
GRANT ALL ON FUNCTION "public"."populate_student_event_details"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."populate_student_event_details"() TO "service_role";



GRANT ALL ON FUNCTION "public"."remove_nulls_from_jsonb"("data" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."remove_nulls_from_jsonb"("data" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."remove_nulls_from_jsonb"("data" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."scheduled_generate_attendance_records"() TO "anon";
GRANT ALL ON FUNCTION "public"."scheduled_generate_attendance_records"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."scheduled_generate_attendance_records"() TO "service_role";



GRANT ALL ON FUNCTION "public"."set_student_color"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_student_color"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_student_color"() TO "service_role";



GRANT ALL ON FUNCTION "public"."set_student_records_academic_year_and_term"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_student_records_academic_year_and_term"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_student_records_academic_year_and_term"() TO "service_role";



GRANT ALL ON FUNCTION "public"."standardize_student_names"() TO "anon";
GRANT ALL ON FUNCTION "public"."standardize_student_names"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."standardize_student_names"() TO "service_role";



GRANT ALL ON FUNCTION "public"."trigger_update_admission_status_daily"() TO "anon";
GRANT ALL ON FUNCTION "public"."trigger_update_admission_status_daily"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."trigger_update_admission_status_daily"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_admission_status_daily"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_admission_status_daily"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_admission_status_daily"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_all_student_ages"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_all_student_ages"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_all_student_ages"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_contacts_timestamp"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_contacts_timestamp"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_contacts_timestamp"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_event_follow_up_interval"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_event_follow_up_interval"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_event_follow_up_interval"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_event_template_interval"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_event_template_interval"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_event_template_interval"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_globals"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_globals"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_globals"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_group_memberships"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_group_memberships"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_group_memberships"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_lookup_on_change"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_lookup_on_change"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_lookup_on_change"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_modified_column"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_modified_column"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_modified_column"() TO "service_role";



GRANT ALL ON TABLE "public"."x_import_admissions" TO "anon";
GRANT ALL ON TABLE "public"."x_import_admissions" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_admissions" TO "service_role";



GRANT ALL ON FUNCTION "public"."update_student_admission"("import_record" "public"."x_import_admissions") TO "anon";
GRANT ALL ON FUNCTION "public"."update_student_admission"("import_record" "public"."x_import_admissions") TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_student_admission"("import_record" "public"."x_import_admissions") TO "service_role";



GRANT ALL ON FUNCTION "public"."update_student_contacts_timestamp"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_student_contacts_timestamp"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_student_contacts_timestamp"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_student_needsoutcomes_audit_fields"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_student_needsoutcomes_audit_fields"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_student_needsoutcomes_audit_fields"() TO "service_role";



SET SESSION AUTHORIZATION "postgres";
RESET SESSION AUTHORIZATION;



SET SESSION AUTHORIZATION "postgres";
RESET SESSION AUTHORIZATION;


















GRANT ALL ON TABLE "public"."accounts" TO "anon";
GRANT ALL ON TABLE "public"."accounts" TO "authenticated";
GRANT ALL ON TABLE "public"."accounts" TO "service_role";



GRANT ALL ON TABLE "public"."actions" TO "anon";
GRANT ALL ON TABLE "public"."actions" TO "authenticated";
GRANT ALL ON TABLE "public"."actions" TO "service_role";



GRANT ALL ON TABLE "public"."audit_log" TO "anon";
GRANT ALL ON TABLE "public"."audit_log" TO "authenticated";
GRANT ALL ON TABLE "public"."audit_log" TO "service_role";



GRANT ALL ON TABLE "public"."confidential_access" TO "anon";
GRANT ALL ON TABLE "public"."confidential_access" TO "authenticated";
GRANT ALL ON TABLE "public"."confidential_access" TO "service_role";



GRANT ALL ON TABLE "public"."contacts" TO "anon";
GRANT ALL ON TABLE "public"."contacts" TO "authenticated";
GRANT ALL ON TABLE "public"."contacts" TO "service_role";



GRANT ALL ON TABLE "public"."error_log" TO "anon";
GRANT ALL ON TABLE "public"."error_log" TO "authenticated";
GRANT ALL ON TABLE "public"."error_log" TO "service_role";



GRANT ALL ON SEQUENCE "public"."error_log_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."error_log_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."error_log_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."event_follow_ups" TO "anon";
GRANT ALL ON TABLE "public"."event_follow_ups" TO "service_role";
GRANT ALL ON TABLE "public"."event_follow_ups" TO "authenticated";



GRANT ALL ON TABLE "public"."event_templates" TO "anon";
GRANT ALL ON TABLE "public"."event_templates" TO "service_role";
GRANT ALL ON TABLE "public"."event_templates" TO "authenticated";



GRANT ALL ON TABLE "public"."globals" TO "anon";
GRANT ALL ON TABLE "public"."globals" TO "authenticated";
GRANT ALL ON TABLE "public"."globals" TO "service_role";



GRANT ALL ON TABLE "public"."groups" TO "anon";
GRANT ALL ON TABLE "public"."groups" TO "authenticated";
GRANT ALL ON TABLE "public"."groups" TO "service_role";



GRANT ALL ON TABLE "public"."links" TO "anon";
GRANT ALL ON TABLE "public"."links" TO "authenticated";
GRANT ALL ON TABLE "public"."links" TO "service_role";



GRANT ALL ON TABLE "public"."lu_academic_years" TO "anon";
GRANT ALL ON TABLE "public"."lu_academic_years" TO "authenticated";
GRANT ALL ON TABLE "public"."lu_academic_years" TO "service_role";



GRANT ALL ON TABLE "public"."lu_applications" TO "anon";
GRANT ALL ON TABLE "public"."lu_applications" TO "authenticated";
GRANT ALL ON TABLE "public"."lu_applications" TO "service_role";



GRANT ALL ON TABLE "public"."lu_categories" TO "anon";
GRANT ALL ON TABLE "public"."lu_categories" TO "authenticated";
GRANT ALL ON TABLE "public"."lu_categories" TO "service_role";



GRANT ALL ON TABLE "public"."lu_counties" TO "anon";
GRANT ALL ON TABLE "public"."lu_counties" TO "authenticated";
GRANT ALL ON TABLE "public"."lu_counties" TO "service_role";



GRANT ALL ON TABLE "public"."lu_diagnosis" TO "anon";
GRANT ALL ON TABLE "public"."lu_diagnosis" TO "authenticated";
GRANT ALL ON TABLE "public"."lu_diagnosis" TO "service_role";



GRANT ALL ON TABLE "public"."lu_group_types" TO "anon";
GRANT ALL ON TABLE "public"."lu_group_types" TO "authenticated";
GRANT ALL ON TABLE "public"."lu_group_types" TO "service_role";



GRANT ALL ON TABLE "public"."lu_record_categories" TO "anon";
GRANT ALL ON TABLE "public"."lu_record_categories" TO "authenticated";
GRANT ALL ON TABLE "public"."lu_record_categories" TO "service_role";



GRANT ALL ON TABLE "public"."lu_record_subcategories" TO "anon";
GRANT ALL ON TABLE "public"."lu_record_subcategories" TO "authenticated";
GRANT ALL ON TABLE "public"."lu_record_subcategories" TO "service_role";



GRANT ALL ON TABLE "public"."lu_roles" TO "anon";
GRANT ALL ON TABLE "public"."lu_roles" TO "authenticated";
GRANT ALL ON TABLE "public"."lu_roles" TO "service_role";



GRANT ALL ON TABLE "public"."lu_terms" TO "anon";
GRANT ALL ON TABLE "public"."lu_terms" TO "authenticated";
GRANT ALL ON TABLE "public"."lu_terms" TO "service_role";



GRANT ALL ON TABLE "public"."notification_distribution" TO "anon";
GRANT ALL ON TABLE "public"."notification_distribution" TO "authenticated";
GRANT ALL ON TABLE "public"."notification_distribution" TO "service_role";



GRANT ALL ON TABLE "public"."notification_header" TO "anon";
GRANT ALL ON TABLE "public"."notification_header" TO "authenticated";
GRANT ALL ON TABLE "public"."notification_header" TO "service_role";



GRANT ALL ON TABLE "public"."organisations" TO "anon";
GRANT ALL ON TABLE "public"."organisations" TO "authenticated";
GRANT ALL ON TABLE "public"."organisations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."records_auto_increment_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."records_auto_increment_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."records_auto_increment_seq" TO "service_role";



GRANT ALL ON TABLE "public"."reports" TO "anon";
GRANT ALL ON TABLE "public"."reports" TO "authenticated";
GRANT ALL ON TABLE "public"."reports" TO "service_role";



GRANT ALL ON TABLE "public"."services" TO "anon";
GRANT ALL ON TABLE "public"."services" TO "authenticated";
GRANT ALL ON TABLE "public"."services" TO "service_role";



GRANT ALL ON TABLE "public"."student_admissions" TO "anon";
GRANT ALL ON TABLE "public"."student_admissions" TO "authenticated";
GRANT ALL ON TABLE "public"."student_admissions" TO "service_role";



GRANT ALL ON TABLE "public"."student_attendance" TO "anon";
GRANT ALL ON TABLE "public"."student_attendance" TO "authenticated";
GRANT ALL ON TABLE "public"."student_attendance" TO "service_role";



GRANT ALL ON TABLE "public"."student_contacts" TO "anon";
GRANT ALL ON TABLE "public"."student_contacts" TO "authenticated";
GRANT ALL ON TABLE "public"."student_contacts" TO "service_role";



GRANT ALL ON TABLE "public"."student_events" TO "anon";
GRANT ALL ON TABLE "public"."student_events" TO "authenticated";
GRANT ALL ON TABLE "public"."student_events" TO "service_role";



GRANT ALL ON TABLE "public"."student_groups" TO "anon";
GRANT ALL ON TABLE "public"."student_groups" TO "authenticated";
GRANT ALL ON TABLE "public"."student_groups" TO "service_role";



GRANT ALL ON TABLE "public"."student_needsoutcomes" TO "anon";
GRANT ALL ON TABLE "public"."student_needsoutcomes" TO "authenticated";
GRANT ALL ON TABLE "public"."student_needsoutcomes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."student_records_serial_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."student_records_serial_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."student_records_serial_seq" TO "service_role";



GRANT ALL ON TABLE "public"."student_records" TO "anon";
GRANT ALL ON TABLE "public"."student_records" TO "authenticated";
GRANT ALL ON TABLE "public"."student_records" TO "service_role";



GRANT ALL ON SEQUENCE "public"."student_records_auto_increment_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."student_records_auto_increment_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."student_records_auto_increment_seq" TO "service_role";



GRANT ALL ON TABLE "public"."student_records_interventions" TO "anon";
GRANT ALL ON TABLE "public"."student_records_interventions" TO "authenticated";
GRANT ALL ON TABLE "public"."student_records_interventions" TO "service_role";



GRANT ALL ON TABLE "public"."student_records_needs" TO "anon";
GRANT ALL ON TABLE "public"."student_records_needs" TO "authenticated";
GRANT ALL ON TABLE "public"."student_records_needs" TO "service_role";



GRANT ALL ON TABLE "public"."student_records_reviews" TO "anon";
GRANT ALL ON TABLE "public"."student_records_reviews" TO "authenticated";
GRANT ALL ON TABLE "public"."student_records_reviews" TO "service_role";



GRANT ALL ON TABLE "public"."student_records_staff" TO "anon";
GRANT ALL ON TABLE "public"."student_records_staff" TO "authenticated";
GRANT ALL ON TABLE "public"."student_records_staff" TO "service_role";



GRANT ALL ON TABLE "public"."student_records_students" TO "anon";
GRANT ALL ON TABLE "public"."student_records_students" TO "authenticated";
GRANT ALL ON TABLE "public"."student_records_students" TO "service_role";



GRANT ALL ON TABLE "public"."student_relational" TO "anon";
GRANT ALL ON TABLE "public"."student_relational" TO "authenticated";
GRANT ALL ON TABLE "public"."student_relational" TO "service_role";



GRANT ALL ON TABLE "public"."student_tags" TO "anon";
GRANT ALL ON TABLE "public"."student_tags" TO "authenticated";
GRANT ALL ON TABLE "public"."student_tags" TO "service_role";



GRANT ALL ON TABLE "public"."students" TO "anon";
GRANT ALL ON TABLE "public"."students" TO "authenticated";
GRANT ALL ON TABLE "public"."students" TO "service_role";



GRANT ALL ON TABLE "public"."terms" TO "anon";
GRANT ALL ON TABLE "public"."terms" TO "authenticated";
GRANT ALL ON TABLE "public"."terms" TO "service_role";



GRANT ALL ON TABLE "public"."user_applications" TO "anon";
GRANT ALL ON TABLE "public"."user_applications" TO "authenticated";
GRANT ALL ON TABLE "public"."user_applications" TO "service_role";



GRANT ALL ON TABLE "public"."user_groups" TO "anon";
GRANT ALL ON TABLE "public"."user_groups" TO "authenticated";
GRANT ALL ON TABLE "public"."user_groups" TO "service_role";



GRANT ALL ON TABLE "public"."user_roles" TO "anon";
GRANT ALL ON TABLE "public"."user_roles" TO "authenticated";
GRANT ALL ON TABLE "public"."user_roles" TO "service_role";



GRANT ALL ON TABLE "public"."user_services" TO "anon";
GRANT ALL ON TABLE "public"."user_services" TO "authenticated";
GRANT ALL ON TABLE "public"."user_services" TO "service_role";



GRANT ALL ON TABLE "public"."view_actions" TO "anon";
GRANT ALL ON TABLE "public"."view_actions" TO "authenticated";
GRANT ALL ON TABLE "public"."view_actions" TO "service_role";



GRANT ALL ON TABLE "public"."view_attendance_codes" TO "anon";
GRANT ALL ON TABLE "public"."view_attendance_codes" TO "authenticated";
GRANT ALL ON TABLE "public"."view_attendance_codes" TO "service_role";



GRANT ALL ON TABLE "public"."weeks" TO "anon";
GRANT ALL ON TABLE "public"."weeks" TO "authenticated";
GRANT ALL ON TABLE "public"."weeks" TO "service_role";



GRANT ALL ON TABLE "public"."view_attendance_kpis" TO "anon";
GRANT ALL ON TABLE "public"."view_attendance_kpis" TO "authenticated";
GRANT ALL ON TABLE "public"."view_attendance_kpis" TO "service_role";



GRANT ALL ON TABLE "public"."view_comprehensive_attendance_statistics" TO "anon";
GRANT ALL ON TABLE "public"."view_comprehensive_attendance_statistics" TO "authenticated";
GRANT ALL ON TABLE "public"."view_comprehensive_attendance_statistics" TO "service_role";



GRANT ALL ON TABLE "public"."view_contacts_info" TO "anon";
GRANT ALL ON TABLE "public"."view_contacts_info" TO "authenticated";
GRANT ALL ON TABLE "public"."view_contacts_info" TO "service_role";



GRANT ALL ON TABLE "public"."view_user_names" TO "anon";
GRANT ALL ON TABLE "public"."view_user_names" TO "authenticated";
GRANT ALL ON TABLE "public"."view_user_names" TO "service_role";



GRANT ALL ON TABLE "public"."view_user_services_info" TO "anon";
GRANT ALL ON TABLE "public"."view_user_services_info" TO "authenticated";
GRANT ALL ON TABLE "public"."view_user_services_info" TO "service_role";



GRANT ALL ON TABLE "public"."view_distinct_users" TO "anon";
GRANT ALL ON TABLE "public"."view_distinct_users" TO "authenticated";
GRANT ALL ON TABLE "public"."view_distinct_users" TO "service_role";



GRANT ALL ON TABLE "public"."view_event_follow_ups" TO "anon";
GRANT ALL ON TABLE "public"."view_event_follow_ups" TO "authenticated";
GRANT ALL ON TABLE "public"."view_event_follow_ups" TO "service_role";



GRANT ALL ON TABLE "public"."view_event_templates" TO "anon";
GRANT ALL ON TABLE "public"."view_event_templates" TO "authenticated";
GRANT ALL ON TABLE "public"."view_event_templates" TO "service_role";



GRANT ALL ON TABLE "public"."view_globals_info" TO "anon";
GRANT ALL ON TABLE "public"."view_globals_info" TO "authenticated";
GRANT ALL ON TABLE "public"."view_globals_info" TO "service_role";



GRANT ALL ON TABLE "public"."view_group_info" TO "anon";
GRANT ALL ON TABLE "public"."view_group_info" TO "authenticated";
GRANT ALL ON TABLE "public"."view_group_info" TO "service_role";



GRANT ALL ON TABLE "public"."view_group_members_info" TO "anon";
GRANT ALL ON TABLE "public"."view_group_members_info" TO "authenticated";
GRANT ALL ON TABLE "public"."view_group_members_info" TO "service_role";



GRANT ALL ON TABLE "public"."view_high_risk_open_records" TO "anon";
GRANT ALL ON TABLE "public"."view_high_risk_open_records" TO "authenticated";
GRANT ALL ON TABLE "public"."view_high_risk_open_records" TO "service_role";



GRANT ALL ON TABLE "public"."view_high_risk_records_grid" TO "anon";
GRANT ALL ON TABLE "public"."view_high_risk_records_grid" TO "authenticated";
GRANT ALL ON TABLE "public"."view_high_risk_records_grid" TO "service_role";



GRANT ALL ON TABLE "public"."view_local_authority_info" TO "anon";
GRANT ALL ON TABLE "public"."view_local_authority_info" TO "authenticated";
GRANT ALL ON TABLE "public"."view_local_authority_info" TO "service_role";



GRANT ALL ON TABLE "public"."view_one_form_categories" TO "anon";
GRANT ALL ON TABLE "public"."view_one_form_categories" TO "authenticated";
GRANT ALL ON TABLE "public"."view_one_form_categories" TO "service_role";



GRANT ALL ON TABLE "public"."view_one_form_statements" TO "anon";
GRANT ALL ON TABLE "public"."view_one_form_statements" TO "authenticated";
GRANT ALL ON TABLE "public"."view_one_form_statements" TO "service_role";



GRANT ALL ON TABLE "public"."view_one_form_subcategories" TO "anon";
GRANT ALL ON TABLE "public"."view_one_form_subcategories" TO "authenticated";
GRANT ALL ON TABLE "public"."view_one_form_subcategories" TO "service_role";



GRANT ALL ON TABLE "public"."view_reports" TO "anon";
GRANT ALL ON TABLE "public"."view_reports" TO "authenticated";
GRANT ALL ON TABLE "public"."view_reports" TO "service_role";



GRANT ALL ON TABLE "public"."view_roles" TO "anon";
GRANT ALL ON TABLE "public"."view_roles" TO "authenticated";
GRANT ALL ON TABLE "public"."view_roles" TO "service_role";



GRANT ALL ON TABLE "public"."view_service_records_summary" TO "anon";
GRANT ALL ON TABLE "public"."view_service_records_summary" TO "authenticated";
GRANT ALL ON TABLE "public"."view_service_records_summary" TO "service_role";



GRANT ALL ON TABLE "public"."view_services" TO "anon";
GRANT ALL ON TABLE "public"."view_services" TO "authenticated";
GRANT ALL ON TABLE "public"."view_services" TO "service_role";



GRANT ALL ON TABLE "public"."view_status_count" TO "anon";
GRANT ALL ON TABLE "public"."view_status_count" TO "authenticated";
GRANT ALL ON TABLE "public"."view_status_count" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_attendance_info" TO "anon";
GRANT ALL ON TABLE "public"."view_student_attendance_info" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_attendance_info" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_attendance_summary" TO "anon";
GRANT ALL ON TABLE "public"."view_student_attendance_summary" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_attendance_summary" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_contacts_info" TO "anon";
GRANT ALL ON TABLE "public"."view_student_contacts_info" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_contacts_info" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_info" TO "anon";
GRANT ALL ON TABLE "public"."view_student_info" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_info" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_emergency_countact_numbers" TO "anon";
GRANT ALL ON TABLE "public"."view_student_emergency_countact_numbers" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_emergency_countact_numbers" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_events_info" TO "anon";
GRANT ALL ON TABLE "public"."view_student_events_info" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_events_info" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_info_grid" TO "anon";
GRANT ALL ON TABLE "public"."view_student_info_grid" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_info_grid" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_links" TO "anon";
GRANT ALL ON TABLE "public"."view_student_links" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_links" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_missing_address" TO "anon";
GRANT ALL ON TABLE "public"."view_student_missing_address" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_missing_address" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_missing_base_group_name" TO "anon";
GRANT ALL ON TABLE "public"."view_student_missing_base_group_name" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_missing_base_group_name" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_missing_dob" TO "anon";
GRANT ALL ON TABLE "public"."view_student_missing_dob" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_missing_dob" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_needsoutcomes" TO "anon";
GRANT ALL ON TABLE "public"."view_student_needsoutcomes" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_needsoutcomes" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_records" TO "anon";
GRANT ALL ON TABLE "public"."view_student_records" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_records" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_records_grid" TO "anon";
GRANT ALL ON TABLE "public"."view_student_records_grid" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_records_grid" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_records_kpis" TO "anon";
GRANT ALL ON TABLE "public"."view_student_records_kpis" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_records_kpis" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_records_needs" TO "anon";
GRANT ALL ON TABLE "public"."view_student_records_needs" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_records_needs" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_records_reviews" TO "anon";
GRANT ALL ON TABLE "public"."view_student_records_reviews" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_records_reviews" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_records_summary" TO "anon";
GRANT ALL ON TABLE "public"."view_student_records_summary" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_records_summary" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_relational" TO "anon";
GRANT ALL ON TABLE "public"."view_student_relational" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_relational" TO "service_role";



GRANT ALL ON TABLE "public"."view_student_tags" TO "anon";
GRANT ALL ON TABLE "public"."view_student_tags" TO "authenticated";
GRANT ALL ON TABLE "public"."view_student_tags" TO "service_role";



GRANT ALL ON TABLE "public"."view_todays_attendance" TO "anon";
GRANT ALL ON TABLE "public"."view_todays_attendance" TO "authenticated";
GRANT ALL ON TABLE "public"."view_todays_attendance" TO "service_role";



GRANT ALL ON TABLE "public"."view_user_roles" TO "anon";
GRANT ALL ON TABLE "public"."view_user_roles" TO "authenticated";
GRANT ALL ON TABLE "public"."view_user_roles" TO "service_role";



GRANT ALL ON TABLE "public"."view_weekly_student_non_attendance" TO "anon";
GRANT ALL ON TABLE "public"."view_weekly_student_non_attendance" TO "authenticated";
GRANT ALL ON TABLE "public"."view_weekly_student_non_attendance" TO "service_role";



GRANT ALL ON TABLE "public"."x_import_actions" TO "anon";
GRANT ALL ON TABLE "public"."x_import_actions" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_actions" TO "service_role";



GRANT ALL ON TABLE "public"."x_import_attendance" TO "anon";
GRANT ALL ON TABLE "public"."x_import_attendance" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_attendance" TO "service_role";



GRANT ALL ON TABLE "public"."x_import_contacts" TO "anon";
GRANT ALL ON TABLE "public"."x_import_contacts" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_contacts" TO "service_role";



GRANT ALL ON TABLE "public"."x_import_needsoutcomes" TO "anon";
GRANT ALL ON TABLE "public"."x_import_needsoutcomes" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_needsoutcomes" TO "service_role";



GRANT ALL ON TABLE "public"."x_import_records" TO "anon";
GRANT ALL ON TABLE "public"."x_import_records" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_records" TO "service_role";



GRANT ALL ON TABLE "public"."x_import_records_reviews" TO "anon";
GRANT ALL ON TABLE "public"."x_import_records_reviews" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_records_reviews" TO "service_role";



GRANT ALL ON TABLE "public"."x_import_student_contacts" TO "anon";
GRANT ALL ON TABLE "public"."x_import_student_contacts" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_student_contacts" TO "service_role";



GRANT ALL ON TABLE "public"."x_import_user_services" TO "anon";
GRANT ALL ON TABLE "public"."x_import_user_services" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_user_services" TO "service_role";



GRANT ALL ON TABLE "public"."x_import_users" TO "anon";
GRANT ALL ON TABLE "public"."x_import_users" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_users" TO "service_role";



GRANT ALL ON TABLE "public"."x_import_weeks" TO "anon";
GRANT ALL ON TABLE "public"."x_import_weeks" TO "authenticated";
GRANT ALL ON TABLE "public"."x_import_weeks" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;
