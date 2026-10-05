using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using OutdoorShop.Data;
using OutdoorShop.Models;

namespace OutdoorShop.Controllers
{
    public class OrderController : Controller
    {
        private readonly ApplicationDbContext _context;

        public OrderController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Checkout()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Checkout(Order order)
        {
            if (!ModelState.IsValid)
            {
                return View(order);
            }

            var cartJson = HttpContext.Session.GetString("Cart");

            if (string.IsNullOrEmpty(cartJson))
            {
                return RedirectToAction("Index", "Cart");
            }

            var cart = JsonSerializer.Deserialize<List<CartItem>>(cartJson);

            if (cart == null || cart.Count == 0)
            {
                return RedirectToAction("Index", "Cart");
            }

            order.CreatedAt = DateTime.Now;

            order.TotalPrice = cart.Sum(item =>
                item.Price * item.Quantity);

            order.Items = new List<OrderItem>();

            foreach (var item in cart)
            {
                order.Items.Add(new OrderItem
                {
                    ProductId = item.ProductId,
                    ProductName = item.ProductName,
                    Price = item.Price,
                    Quantity = item.Quantity,
                    TotalPrice = item.Price * item.Quantity
                });
            }

            _context.Orders.Add(order);

            await _context.SaveChangesAsync();

            HttpContext.Session.Remove("Cart");

            return RedirectToAction("Success");
        }

        public IActionResult Success()
        {
            return View();
        }
    }
}