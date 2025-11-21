using Microsoft.Data.SqlClient;
using System.Threading.Tasks;
using System.Collections.Generic;
using LHPets.Models;

public class Banco
{
    private readonly string _connectionString;
    private List<Cliente> listaClientes; // Lista como atributo

    public Banco(string connectionString)
    {
        _connectionString = connectionString;
        listaClientes = new List<Cliente>();
    }

    public async Task<List<Cliente>> GetClientesAsync()
    {
        listaClientes = new List<Cliente>();
        using var conn = new SqlConnection(_connectionString);
        await conn.OpenAsync();

        using var cmd = conn.CreateCommand();
        cmd.CommandText = "SELECT Id, Nome, Email, Cidade FROM tblclientes";

        using var reader = await cmd.ExecuteReaderAsync();
        while (await reader.ReadAsync())
        {
            var id = reader.GetInt32(reader.GetOrdinal("Id"));
            var nome = reader.GetString(reader.GetOrdinal("Nome"));
            var email = reader.IsDBNull(reader.GetOrdinal("Email")) ? "" : reader.GetString(reader.GetOrdinal("Email"));
            var cidade = reader.IsDBNull(reader.GetOrdinal("Cidade")) ? "" : reader.GetString(reader.GetOrdinal("Cidade"));
            
            // Usando cidade como CPF temporário e email como está, paciente vazio por enquanto
            var c = new Cliente(id, nome, cidade, email, "");
            listaClientes.Add(c);
        }

        return listaClientes;
    }
}