import base64
import json
import uuid


class AuthHelper:
    """Custom keyword library for token manipulation and test data utilities."""

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def generate_random_email(self, domain: str = "test.local") -> str:
        """Generates a unique email for registration tests."""
        return f"user_{uuid.uuid4().hex[:8]}@{domain}"

    def decode_jwt_payload(self, token: str) -> dict:
        """Decodes the unverified payload of a JWT token for assertion checks."""
        parts = token.split(".")
        if len(parts) < 2:
            raise ValueError("Invalid JWT format")
        payload_b64 = parts[1]
        # Adjust base64 padding
        payload_b64 += "=" * ((4 - len(payload_b64) % 4) % 4)
        decoded = base64.urlsafe_b64decode(payload_b64.encode("utf-8"))
        return json.loads(decoded.decode("utf-8"))

    def build_bearer_header(self, token: str) -> dict:
        """Formats an Authorization header dictionary."""
        return {"Authorization": f"Bearer {token}", "Content-Type": "application/json"}