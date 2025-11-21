using Microsoft.Data.SqlClient;
using System.Threading.Tasks;
using System.Collections.Generic;

public class Banco
{
    private readonly string _connectionString;
    public Banco(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<List<Cliente>> GetClientesAsync()
    {
        var lista = new List<Cliente>();
        using var conn = new SqlConnection(_connectionString);
        await conn.OpenAsync();

        using var cmd = conn.CreateCommand();
        cmd.CommandText = "SELECT Id, Nome, Email, Cidade FROM tblclientes";

        using var reader = await cmd.ExecuteReaderAsync();
        while (await reader.ReadAsync())
        {
            var c = new Cliente
            {
                Id = reader.GetInt32(reader.GetOrdinal("Id")),
                Nome = reader.GetString(reader.GetOrdinal("Nome")),
                Email = reader.IsDBNull(reader.GetOrdinal("Email")) ? null : reader.GetString(reader.GetOrdinal("Email")),
                Cidade = reader.IsDBNull(reader.GetOrdinal("Cidade")) ? null : reader.GetString(reader.GetOrdinal("Cidade"))
            };
            lista.Add(c);
        }

        return lista;
    }
}