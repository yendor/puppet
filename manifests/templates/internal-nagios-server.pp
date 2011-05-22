class internal-nagios-server($instance_name)
{
	include nagios3::common
	include apache2::mpm-prefork

	file { "/etc/apache2/ssl":
		ensure => "directory",
	}

	class { "nagios3::server":
		instance_name => $instance_name,
		nagios_version => '3.2.1-2~bpo50+1',
		nagios_ssl_key_file => "/etc/apache2/ssl/server.key",
		nagios_ssl_cert_file => "/etc/apache2/ssl/server.crt",
		nagios_web_ip => "*"
	}

	file { "/etc/apache2/ssl/server.key":
		content => "-----BEGIN PRIVATE KEY-----
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQD3vr9QMLrN5XYI
FKLz8aVfnYOPinrdHPPZx7i3FotgnwauM+Ys6HU8Qm9pfEOD/+xse/JKxUkKk2g+
OOchRXqG0hYvDumzJAcdlv5plJxUEVV9vI1K4GAiadpwCuStPQmbVW0qX1f38yn6
cpGVNGj7jgpP5kKATMZfNcwAjQ/9eWe0aKCImxZhd1t2HXRYV7WzcMucbbWv5akb
dk+TuvZkz3QDmIv6BVZZGXZWsm7gt51IO+4cgSNc/dNGs/MYqUJ8RY67Sn1gNENn
vnt3cOyAK1jbnMX1Av2qpVGMAtrAbJRAmZP9s7958pMH+sQ2001uBSNpfGp3uXcR
MdfmyZy/AgMBAAECggEAV5d+RpjkAxYE1DiPoJYoNRUYxbBdXj31TWNawIjdAG1Z
TFAXKnuJr6OBhpcju9DJQ1XTRXJZL78MVSuDNHU/K9mtdDfekrLDPUf8bVHYr7Rt
OIZoojeQZbptO73uOf3hnqTmctvA226CwgStykX8dCw1IyizDG+Yl2MK3IsDQ0du
OVekMlXfhc3EwrmdjQVFzhxGWeeU3TmHAN64dqPcyJD4H4Qqdx0Ei/VLMr6wxDgB
KGNOuXfgtIpz3H3knsj5ISeuvTDhSOdsGjlt3y90lyVZmXsLRllAhkbItH+DjLGa
vFisl0dp6zac6h6zgQ74JPd5CVf3YwPa1duOikxDyQKBgQD7+Vgfn3Q3uBcEjqdT
QbfXGJL+jJ7EJKgV/C/u+wo5jaIPN+bREXxJ9kOog4mlx1bv6vsoX+3RmhwjaKzh
LpFidEkqAdCvxA9ZDlDHJ8w4COMLq0y58WVUC1CNmv3tjHNafihk8CtnuURpXm1p
+WE641ns6OgiHPzTD1Nhb+pZXQKBgQD7tBsD/OqdK8EHJBzHVghYGUqIgU7oTHLh
VCIL/uUAoMzj7EtpfYnQgSzwrokTqkGmQYFv09vOKRDFNpUYNFef7XYGeRGGLI9G
+2x861I+MsiehF89tHtvtmKvuyU1i4HpDWOjqDVpgBYMZflXuUIyq7rCAAKdJnnM
1XvRtrvAywKBgASbJD8/vPIfzVvp96kP9HpcGqPIkkZnnSL5vy6RLDitHB9HGFMO
DMWVWNtFvEhpgm9UTk8IoeJI/OawzSg4n7O7CHNaISR1Ywpvto5NbfBASVY3RWnI
vd9xbYGJKccj4B/xWm+t7D0zJ8r9TOa5Bkv7R/OKtmOZQA3jo9SOJSyJAoGAX/Fe
Ht4IPBLSiDtOsPjtQ0+YpoHLpyaE37knJTVq6xtgHj0S3coZfx3OGIwe+hz62zm6
8fpqnaHvn4zXths1j2N/iqYZdPCFSMRLrS4x8j1/VVUVzLqAFqwJ3/xRCaD8yu3s
nhRfD7DgNqekLLkUL6ZgENTaKjbhVJ/Hi7/Av5MCgYBFphXC5G4HL8uRgQh+CqG5
NjjVMAXABltIeXHx471lz4NgBzdwCbh1P+JxZICTkI/6wyEsbKF1LBCiaQbiRE1N
LCI0fvv5PrvyM3gjy0/uFpCDSRAosNnygBD/93qdy12cJMIPEnRRu6mkBCYjtuY1
gTvsxMYQnl3MZt9B4XQh0g==
-----END PRIVATE KEY-----
		"
	}

	file { "/etc/apache2/ssl/server.crt":
		content => "-----BEGIN CERTIFICATE-----
MIIDgTCCAmmgAwIBAgIJAKfU/uVJvZgYMA0GCSqGSIb3DQEBBQUAMFcxCzAJBgNV
BAYTAkFVMRgwFgYDVQQIDA9OZXcgU291dGggV2FsZXMxFTATBgNVBAoMDFJvZG5l
eXMgVGVzdDEXMBUGA1UEAwwOKi52aXJ0dWFsLmRvam8wHhcNMTEwNTE4MDA0NjI5
WhcNMjEwNTE1MDA0NjI5WjBXMQswCQYDVQQGEwJBVTEYMBYGA1UECAwPTmV3IFNv
dXRoIFdhbGVzMRUwEwYDVQQKDAxSb2RuZXlzIFRlc3QxFzAVBgNVBAMMDioudmly
dHVhbC5kb2pvMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA976/UDC6
zeV2CBSi8/GlX52Dj4p63Rzz2ce4txaLYJ8GrjPmLOh1PEJvaXxDg//sbHvySsVJ
CpNoPjjnIUV6htIWLw7psyQHHZb+aZScVBFVfbyNSuBgImnacArkrT0Jm1VtKl9X
9/Mp+nKRlTRo+44KT+ZCgEzGXzXMAI0P/XlntGigiJsWYXdbdh10WFe1s3DLnG21
r+WpG3ZPk7r2ZM90A5iL+gVWWRl2VrJu4LedSDvuHIEjXP3TRrPzGKlCfEWOu0p9
YDRDZ757d3DsgCtY25zF9QL9qqVRjALawGyUQJmT/bO/efKTB/rENtNNbgUjaXxq
d7l3ETHX5smcvwIDAQABo1AwTjAdBgNVHQ4EFgQUbnv+vtyXFyeI25nzq46ISaXn
ftowHwYDVR0jBBgwFoAUbnv+vtyXFyeI25nzq46ISaXnftowDAYDVR0TBAUwAwEB
/zANBgkqhkiG9w0BAQUFAAOCAQEAvZO7bFFZpKrc8fLyNLaehU7/B2yhUhtmd/ax
YddWkr+sW78tGWW8oL0ktbR0gb/Hjd/wsSNFPc8xpFJ6/ZbtSgFUEfMoaQccynwM
MoBXBLL/usJg1Bwx4Rb19P23+9soiskEPXzY+0suryrnO+yRHitUv5vVrSU/y1c4
emBnXa8NdljCSD32aB4Ng64pQ8gBFJ7i4IiscmfPwsnr6hgTF7I5sDYcM0rfczdz
7uCzpf93T5bTVGM4A4L5KmA9rqp5UYCc+eja7RkmCzAopuCJI+I1YoQVltbT5Ldw
bxjgnrluoQtm8ac6WCLvTYeBirKhMCLzp4NYrd+ONZUXlS5ujA==
-----END CERTIFICATE-----
		"
	}
}