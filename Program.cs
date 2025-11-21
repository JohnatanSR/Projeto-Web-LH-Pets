using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

var builder = WebApplication.CreateBuilder(args);

// Adicionar serviços MVC
builder.Services.AddControllersWithViews();

// carregar appsettings.json (já é carregado por default)
var config = builder.Configuration;

// registrar Banco como serviço (injetando connection string) - opcional para futuro
builder.Services.AddScoped<Banco>(_ => new Banco(config.GetConnectionString("Vendas")));

var app = builder.Build();

// Configurar pipeline HTTP
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

// Configurar rotas MVC
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();