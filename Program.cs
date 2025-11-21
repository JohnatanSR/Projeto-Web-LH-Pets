using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

var builder = WebApplication.CreateBuilder(args);

// carregar appsettings.json (já é carregado por default)
var config = builder.Configuration;

// registrar Banco como serviço (injetando connection string)
builder.Services.AddScoped<Banco>(_ => new Banco(config.GetConnectionString("Vendas")));

var app = builder.Build();

// Habilitar servir arquivos estáticos (wwwroot/index.html)
app.UseDefaultFiles(); // procura index.html
app.UseStaticFiles();

// rota "/" -> string simples
app.MapGet("/", () => Results.Text("LH Pets - Protótipo 1"));

// rota "/index" -> redireciona para index.html (que está em wwwroot)
app.MapGet("/index", (HttpContext ctx) =>
{
    ctx.Response.Redirect("/index.html");
    return Task.CompletedTask;
});

// rota "/listaClientes" -> buscar do banco e retornar HTML simples
app.MapGet("/listaClientes", async (Banco banco) =>
{
    var clientes = await banco.GetClientesAsync();

    // montar HTML simples com a lista
    var html = "<!doctype html><html><head><meta charset='utf-8'><title>Lista de Clientes</title></head><body>";
    html += "<h1>Lista de Clientes</h1>";
    html += "<ul>";
    foreach (var c in clientes)
    {
        html += $"<li>{System.Net.WebUtility.HtmlEncode(c.Nome)} - {System.Net.WebUtility.HtmlEncode(c.Email ?? "")} - {System.Net.WebUtility.HtmlEncode(c.Paciente ?? "")}</li>";
    }
    html += "</ul>";
    html += "</body></html>";

    return Results.Content(html, "text/html");
});

app.Run();