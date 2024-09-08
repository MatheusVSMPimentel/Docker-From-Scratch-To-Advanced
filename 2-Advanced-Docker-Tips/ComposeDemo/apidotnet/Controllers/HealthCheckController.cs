using Microsoft.AspNetCore.Mvc;

namespace apidotnet.Controllers
{
    [ApiController]
    public class HealthCheckController : ControllerBase
    {
        [HttpGet("healthz")]
        public IActionResult Get(int stats = 0)
        {
            if (stats != 0) return StatusCode(503, "Unhealthy");

            return Ok("Healthy");
        }
    }
}
