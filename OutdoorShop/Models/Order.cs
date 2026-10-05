namespace OutdoorShop.Models
{
    public class Order
    {
        public int Id { get; set; }

        public string CustomerName { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;

        public string Phone { get; set; } = string.Empty;

        public string Address { get; set; } = string.Empty;

        public decimal TotalPrice { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.Now;

        public List<OrderItem> Items { get; set; } = new();
    }
}