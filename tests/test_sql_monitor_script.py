import re
import unittest
from pathlib import Path

SQL_SCRIPT = Path(__file__).resolve().parents[1] / "v$sql_monitor.sql"


class SqlMonitorScriptTest(unittest.TestCase):
    def test_human_guidance_lines_are_commented(self):
        guidance_phrases = ("məqsədin", "Hazırda sistemi")

        for line_number, raw_line in enumerate(
            SQL_SCRIPT.read_text().splitlines(), start=1
        ):
            line = raw_line.strip()
            if any(phrase in line for phrase in guidance_phrases):
                self.assertTrue(
                    line.startswith("--"), f"line {line_number} must be a comment"
                )

    def test_concrete_sql_monitor_report_examples_do_not_include_placeholder_brackets(
        self,
    ):
        script = SQL_SCRIPT.read_text()

        sql_id_values = re.findall(r"sql_id\s*=>\s*'([^']+)'", script)

        self.assertGreaterEqual(len(sql_id_values), 1)
        concrete_sql_ids = [value for value in sql_id_values if value != "<sql_id>"]
        self.assertTrue(
            all(
                not value.startswith("<") and not value.endswith(">")
                for value in concrete_sql_ids
            )
        )


if __name__ == "__main__":
    unittest.main()
