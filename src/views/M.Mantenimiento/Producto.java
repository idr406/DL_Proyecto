public class Producto {
    private int idProducto;
    private String nombre;
    private double precioCompra;
    private double precioVenta;
    private int stock;
    private Proveedor proveedor; // Relación directa con el objeto Proveedor

    public Producto(int id, String nombre, double pCompra, double pVenta, int stock, Proveedor prov) {
        this.idProducto = id;
        this.nombre = nombre;
        this.precioCompra = pCompra;
        this.precioVenta = pVenta;
        this.stock = stock;
        this.proveedor = prov;
    }
    
    // Método para calcular margen de ganancia
    public double getMargen() {
        return this.precioVenta - this.precioCompra;
    }
}