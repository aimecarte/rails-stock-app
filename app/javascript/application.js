// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

document.addEventListener("DOMContentLoaded", function () {
  // Get the button and table elements
  const toggleButton = document.getElementById("toggleButton");
  const userTable = document.getElementById("userTable");
  const tableDiv = document.getElementById("traderTable");
  const allTraderHeader = document.getElementById("allTrader");
  const allUserHeader = document.getElementById("allUser");

  // Set the table to be hidden by default
  traderTable.style.display = "none"; // Ensure it's hidden when the page loads
  allTraderHeader.style.display = "none"; // Ensure trader header is hidden when the page loads

  // Set the initial button text
  toggleButton.textContent = "Show Trader User";

  // Add event listener for button click
  toggleButton.addEventListener("click", function () {
    // Check which table is currently visible and toggle visibility
    if (userTable.style.display === "none") {
      // Show user table and header
      userTable.style.display = "block";
      allUserHeader.style.display = "block";

      // Hide trader table and header
      traderTable.style.display = "none";
      allTraderHeader.style.display = "none";

      // Update button text
      toggleButton.textContent = "Show Trader User";
    } else {
      // Show trader table and header
      traderTable.style.display = "block";
      allTraderHeader.style.display = "block";

      // Hide user table and header
      userTable.style.display = "none";
      allUserHeader.style.display = "none";

      // Update button text
      toggleButton.textContent = "Show All User";
    }
  });
});
