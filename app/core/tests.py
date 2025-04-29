from django.test import TestCase
from django.urls import reverse


class CoreTests(TestCase):
    def test_home_page(self):
        """Test that the home page returns a 200 status code."""
        response = self.client.get(reverse('home'))
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Welcome to Django!', response.content)

    def test_health_check(self):
        """Test that the health check endpoint returns a 200 status code."""
        response = self.client.get(reverse('health_check'))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.content, b'OK') 