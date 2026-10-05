using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OutdoorShop.Data;
using OutdoorShop.Models;

namespace OutdoorShop.Controllers
{
    public class CartController : Controller
    {
        private readonly ApplicationDbContext _context;

        public CartController(ApplicationDbContext context)
        {
            _context = context;
        }

        // Показва количката
        public IActionResult Index()
        {
            var cart = GetCart();

            return View(cart);
        }

        // Добавя продукт
        [HttpPost]
        public async Task<IActionResult> Add(int productId)
        {
            var product = await _context.Products
                .FirstOrDefaultAsync(p => p.Id == productId);

            if (product == null)
            {
                return NotFound();
            }

            var cart = GetCart();

            var existingItem = cart.FirstOrDefault(x => x.ProductId == productId);

            if (existingItem != null)
            {
                existingItem.Quantity++;
            }
            else
            {
                cart.Add(new CartItem
                {
                    ProductId = product.Id,
                    ProductName = product.Name,
                    Price = product.Price,
                    Quantity = 1,
                    ImageUrl = product.ImageUrl
                });
            }

            SaveCart(cart);

            return RedirectToAction("Index");
        }

        // Увеличава количеството
        [HttpPost]
        public IActionResult Increase(int productId)
        {
            var cart = GetCart();

            var item = cart.FirstOrDefault(x => x.ProductId == productId);

            if (item != null)
            {
                item.Quantity++;
            }

            SaveCart(cart);

            return RedirectToAction("Index");
        }

        // Намалява количеството
        [HttpPost]
        public IActionResult Decrease(int productId)
        {
            var cart = GetCart();

            var item = cart.FirstOrDefault(x => x.ProductId == productId);

            if (item != null)
            {
                item.Quantity--;

                if (item.Quantity <= 0)
                {
                    cart.Remove(item);
                }
            }

            SaveCart(cart);

            return RedirectToAction("Index");
        }

        // Премахва продукта
        [HttpPost]
        public IActionResult Remove(int productId)
        {
            var cart = GetCart();

            var item = cart.FirstOrDefault(x => x.ProductId == productId);

            if (item != null)
            {
                cart.Remove(item);
            }

            SaveCart(cart);

            return RedirectToAction("Index");
        }

        // Взима количката от Session
        private List<CartItem> GetCart()
        {
            var cartJson = HttpContext.Session.GetString("Cart");

            if (string.IsNullOrEmpty(cartJson))
            {
                return new List<CartItem>();
            }

            return JsonSerializer.Deserialize<List<CartItem>>(cartJson)
                   ?? new List<CartItem>();
        }

        // Запазва количката в Session
        private void SaveCart(List<CartItem> cart)
        {
            var cartJson = JsonSerializer.Serialize(cart);

            HttpContext.Session.SetString("Cart", cartJson);
        }
    }
}