using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OutdoorShop.Data;
using OutdoorShop.Models;

namespace OutdoorShop.Controllers
{
    public class ProductsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ProductsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // Всички продукти
        public async Task<IActionResult> Index()
        {
            var products = await _context.Products
                .Include(p => p.Category)
                .ToListAsync();

            return View(products);
        }

        // CREATE - показва формата
        [HttpGet]
        public async Task<IActionResult> Create()
        {
            ViewBag.Categories = await _context.Categories
                .ToListAsync();

            return View();
        }

        // CREATE - записва продукта
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Product product)
        {
            if (!ModelState.IsValid)
            {
                ViewBag.Categories = await _context.Categories
                    .ToListAsync();

                return View(product);
            }

            _context.Products.Add(product);
            await _context.SaveChangesAsync();

            return RedirectToAction(nameof(Index));
        }

        // EDIT - показва формата
        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {
            var product = await _context.Products.FindAsync(id);

            if (product == null)
            {
                return NotFound();
            }

            ViewBag.Categories = await _context.Categories
                .ToListAsync();

            return View(product);
        }

        // EDIT - записва промените
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Product product)
        {
            if (id != product.Id)
            {
                return NotFound();
            }

            if (!ModelState.IsValid)
            {
                ViewBag.Categories = await _context.Categories
                    .ToListAsync();

                return View(product);
            }

            _context.Products.Update(product);
            await _context.SaveChangesAsync();

            return RedirectToAction(nameof(Index));
        }

        // DELETE - потвърждение
        [HttpGet]
        public async Task<IActionResult> Delete(int id)
        {
            var product = await _context.Products
                .Include(p => p.Category)
                .FirstOrDefaultAsync(p => p.Id == id);

            if (product == null)
            {
                return NotFound();
            }

            return View(product);
        }

        // DELETE - изтриване
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var product = await _context.Products.FindAsync(id);

            if (product == null)
            {
                return NotFound();
            }

            _context.Products.Remove(product);
            await _context.SaveChangesAsync();

            return RedirectToAction(nameof(Index));
        }
    }
}