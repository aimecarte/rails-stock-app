// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

document.addEventListener("DOMContentLoaded", function () {
  // Get the button and table elements
  const toggleButton = document.getElementById("toggleButton");
  const userTable = document.getElementById("userTable");
  const tableDiv = document.getElementById("traderTable");

  // Set the table to be hidden by default
  traderTable.style.display = "none"; // Ensure it's hidden when the page loads

  // Set the initial button text
  toggleButton.textContent = "Show Trader User";

  // Add event listener for button click
  toggleButton.addEventListener("click", function () {
    // Check which table is currently visible and toggle visibility
    if (userTable.style.display === "none") {
      userTable.style.display = "block"; // Show user table
      traderTable.style.display = "none"; // Hide trader table
      toggleButton.textContent = "Show Trader User"; // Update button text
    } else {
      userTable.style.display = "none"; // Hide user table
      traderTable.style.display = "block"; // Show trader table
      toggleButton.textContent = "Show All User"; // Update button text
    }
  });
});
